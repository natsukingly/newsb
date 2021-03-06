require_relative 'boot'
require 'rails/all'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'nokogiri'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.


Bundler.require(*Rails.groups)

module NewsParty
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    Rails.application.config.enable_dependency_loading = true
    config.autoload_paths += %W(#{config.root}/lib/tasks/)
    # config.eager_load_paths += Dir["#{config.root}/lib/tasks/"]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
