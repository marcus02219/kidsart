require 'carrierwave/mongoid'

CarrierWave.configure do |config|
  # if Rails.env.production?
  #   config.fog_credentials = {
  #     :provider               => 'AWS',
  #     :aws_access_key_id      => ENV['S3_API_KEY_ID'],
  #     :aws_secret_access_key  => ENV['S3_API_SECRET_KEY'],
  #     :region                 => 'eu-west-1',                       #ENV['S3_API_REGION']
  #     #:host                   => "#{ENV['S3_API_ASSET_URL']}/#{ENV['S3_API_BUCKET_NAME']}",
  #     #:endpoint               => 'http://headcountapp.s3-website-us-west-1.amazonaws.com' # optional, defaults to nil
  #   }
  #   config.fog_directory  = 'headcountapp'
  #   config.fog_public     = false                                   # optional, defaults to true
  #   config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  #
  # else
    config.storage   = ':grid_fs'
    config.root = Rails.root.join('tmp')
    config.cache_dir = "uploads"
  # end

end
