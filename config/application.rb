require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LikelionMusicKitchen
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_record.raise_in_transactional_callbacks = true
    Yt.configuration.api_key = ENV['GOOGLE_YOUTUBE_KEY']
    Yt.configuration.client_id = ENV['GOOGLE_CLIENT_ID']           ## replace with your client ID
    Yt.configuration.client_secret = ENV['GOOGLE_SECRET']   ## replace with your client secret
    
  end
end
