require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Projects
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: false,
        15 view_specs: false,
        16 helper_specs: false,
        17 routing_specs: false
      g.factory_bot false
    end
  end
end
