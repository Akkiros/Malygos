namespace :malygos do
  desc "Sync your local assets to amazon s3"
  task :sync do
    connect = Malygos.connect
    Malygos.sync
    Malygos.disconnect
  end

  desc "Delete all remote assets on amazon s3"
  task :delete_remote_assets do
    connect = Malygos.connect
    Malygos.delete_all_remote_assets
    Malygos.disconnect
  end
end
