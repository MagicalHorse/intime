# encoding: utf-8
IntimeService::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  #config.action_controller.show_full_error_reports = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Expands the lines which load the assets
  config.assets.debug = true

  config.active_record.logger = Logger.new(STDOUT)
  config.active_resource.logger = Logger.new(STDOUT)
end
CARD_INFO_URL = "http://guide.intime.com.cn:8008/intimers/api/vipinfo/queryinfo"
CARD_POINT_URL = "http://guide.intime.com.cn:8008/intimers/api/vipinfo/queryscore"
CARD_EXCHANGE_URL = "http://guide.intime.com.cn:8008/intimers/api/vipinfo/exchange"
