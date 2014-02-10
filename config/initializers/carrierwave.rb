# for development environment
if Rails.env.development? or Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
  end
end

# for production environment
if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog

    # amazon AWS storage information
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAI4QMAGZUWULDTNRQ',
      :aws_secret_access_key  => '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',
    }
    config.fog_directory  = 'amonograph_media'
    config.fog_public     = false
  end
end

