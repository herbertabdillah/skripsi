require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ais
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.hosts << "ais.h-1.localhost"
    config.hosts << "ais.h-1.cloud"
    config.hosts << "skripsi.h-1.localhost"
    config.hosts << "localhost"
    config.hosts << "127.0.0.1"
    config.hosts << "skripsi.h-1.cloud"
    config.action_dispatch.ip_spoofing_check = false
  end
end
