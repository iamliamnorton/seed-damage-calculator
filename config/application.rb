require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fasdac
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Google Analytics tracking code
    GA.tracker = "UA-32798272-1"

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
