require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true


  config.assets.compile = true
  config.serve_static_assets = true 
  config.assets.digest = true
  config.active_storage.service = :local

  
  config.force_ssl = false

  # Log to STDOUT by default
  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # "info" includes generic and useful information about system operation, but avoids logging too much
  # information to avoid inadvertent exposure of personally identifiable information (PII). If you
  # want to log everything, set the level to "debug".
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")


  config.action_mailer.perform_caching = false

  
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.report_deprecations = false
  # config.active_storage.service = :disk
  config.active_storage.service = :render

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
  # config.config.read_encrypted_secrets = true
  
end
