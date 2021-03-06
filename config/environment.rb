# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
require 'lib/string_extension'

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  config.load_paths += %W( #{RAILS_ROOT}/app/observers )

  # Specify gems that this application depends on and have them installed with rake gems:install
  config.gem 'will_paginate',     :version => '2.3.11'
  config.gem 'authlogic',         :version => '2.1.3'
  config.gem 'net-toc',           :version => '0.2', :lib => 'net/toc'
  config.gem 'xmpp4r-simple',     :version => '0.8.8'
  config.gem 'httparty',          :version => '0.5.0'
  config.gem 'gchartrb',          :version => '0.8', :lib => 'google_chart'
  config.gem 'hoptoad_notifier',  :version => '2.1.3'
  #config.gem 'rspreedly',     :version => '0.1.11'
  
  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  config.active_record.observers = :message_observer, :subscription_observer, :user_observer, :group_observer, :group_membership_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end