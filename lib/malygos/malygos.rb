module Malygos
  class << self
    def connect
      @aws_key = YAML.load(File.read("#{Rails.root}/config/malygos.yml"))

      @connect ||= Aws::S3::Client.new(
        region: @aws_key['region'],
        access_key_id: @aws_key['access_key_id'],
        secret_access_key: @aws_key['secret_access_key']
      )

      @log = File.open("#{Rails.root}/log/#{Time.now.strftime("%Y-%m-%d")}-malygos.log", "a+")
    end

    def disconnect
      @log.close
    end

    def bucket
      @bucket ||= @aws_key['bucket']
    end

    def acl
      @acl ||= @aws_key['acl']
    end

    def sync
      puts "Start"

      local_list = get_local_assets
      remote_list = get_remote_assets
      file_list = local_list - remote_list

      if file_list == []
        puts("all files updated.")
        return
      end

      upload_assets(file_list)

      puts "Success! upload #{file_list.length} files."
    end

    def delete_all_remote_assets
      list = get_remote_assets

      success_num = delete_remote_assets(list)

      puts "delete #{list.length}, success: #{success_num} assets from s3."
    end

    def upload_assets(file_list)
      file_list.each do |f|
        File.open(f, 'rb') do |file|
          puts File.path(f)
          @connect.put_object(
            bucket: bucket, key: File.path(f), body: file, acl: acl
          )
        end
        log("upload", f)
      end
    end

    def delete_remote_assets(file_list)
      puts "Start"
      success = 0

      if file_list == []
        puts("no files to delete")
        return success
      end

      file_list.each do |f|
        result = @connect.delete_object(
          bucket: bucket, key: File.path(f)
        )
        success += 1 if result.delete_marker == nil
        log("delete", f)
      end

      success
    end

    def get_local_assets
      local_file_list = []
      path = "#{Rails.root}/public/**/*"

      Dir.glob(path) do |fname|
        local_file_list << fname.sub("#{Rails.root}/", "") if File.file?(fname)
      end

      local_file_list
    end

    def get_remote_assets
      obj = @connect.list_objects(bucket: bucket)
      remote_file_list = []

      obj.contents.each do |object|
        remote_file_list << object.key
      end

      remote_file_list
    end

    def log(status, body)
      @log.write("#{Time.now} #{status}: #{body}\n")
    end
  end
end
