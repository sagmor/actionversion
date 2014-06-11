require File.expand_path('../boot', __FILE__)

require 'active_model/railtie'
require 'action_controller/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Example
  class Application < Rails::Application
    config.middleware.use ActionVersion::Middleware, default: Time
  end
end
