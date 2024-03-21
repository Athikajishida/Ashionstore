require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyFirstProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_paths += %W(#{config.root}/lib)

    config.to_prepare do
      Devise::SessionsController.layout "user_layouts"
      Devise::RegistrationsController.layout "user_layouts"
      Devise::ConfirmationsController.layout "user_layouts"
      Devise::UnlocksController.layout "user_layouts"            
      Devise::PasswordsController.layout "user_layouts"
    end

    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    config.action_mailer.delivery_method = :smtp

    ActionMailer::Base.smtp_settings = {
      address: 'smtp.gmail.com',
      port: '587',
      authentication: :plain,
      user_name: 'athikajishida@gmail.com',
      password: "yopg jilu hcis tmtp",
      domain: 'render.com',
      enable_starttls_auto: true
    }

    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.before_configuration do
      env_file = Rails.root.join("config", "razorpay.yml")
    
      if File.exist?(env_file)
        env_config = YAML.load_file(env_file)[Rails.env] || {}
        env_config.each do |key, value|
          ENV[key.to_s] = value.to_s
        end
      end
    end
  end
end
