# Malygos

Rails assets sync to Amazon S3 only

## Installation

Add this line to your application's Gemfile:

    gem 'malygos'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install malygos

## Usage

First, add ``malygos.yml`` in your rails project ``config/`` and add your s3 keys like this.

```ruby
access_key_id: YOUR_ACCESS_KEY
secret_access_key: YOUR_SECRET_ACCESS_KEY
region: YOUR_S3_REGION
bucket: YOUR_S3_BUCKET
acl: ACL_YOU_WANT # like "public-read"
```

And after, run ``rake malygos:sync`` or ``rake malygos:delete\_remote\_assets``.

If you run ``rake malygos:sync``, Malygos upload your assets that not in remote s3.  
and run ``rake malygos:delete\_remote\_assets``, delete all assets in remote s3.

## Contributing

1. Fork it ( https://github.com/Akkiros/malygos/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Author

Wonjae Kim / [@Akkiros][Facebook]

[Facebook]: https://www.facebook.com/akkiros
