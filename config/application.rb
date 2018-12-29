require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fasdac
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ['metric', 'imperial']
    config.i18n.default_locale = :"imperial"

    config.backpaddock = {
      url: "http://www.backpaddock.com.au",
    }

    config.footer_url = "https://github.com/iamliamnorton"

    config.ipni = {
      alt: "IPNI Logo",
      image: "ipni_logo.png",
      title: "International Plant Nutrition Institue",
      url: "https://www.ipni.net",
    }

    config.sdsu = {
      alt: "SDSU Logo",
      image: "sdsu_logo.png",
      title: "South Dakota State University",
      url: "https://www.sdstate.edu",
    }

    config.generators do |g|
      # Machinist to auto add blueprints for generated models
      g.fixture_replacement :machinist
    end
  end
end
