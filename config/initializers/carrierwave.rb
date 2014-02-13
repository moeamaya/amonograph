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
      :aws_access_key_id      => ENV["AWS_KEY"],
      :aws_secret_access_key  => ENV["AWS_SECRET"],
    }
    config.fog_directory  = 'amonograph_drawing'
    config.fog_public     = false
  end
end

