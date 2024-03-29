# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require 'thread'
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  config.gem "authlogic" , :version => '2.1.6'
  # config.gem "nokogiri" , :version => '1.4.4'
  config.gem "be9-acl9"  , :source  => "http://gems.github.com", :lib => "acl9"
  config.gem "pusher"    , :version => '0.9.4'
  config.gem "multi_json", :version => '1.3.6'
  config.gem "signature" , :version => '0.1.3'
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Brasilia'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = "pt-BR"
end

require 'pusher'
Pusher.logger = Rails.logger
Pusher.app_id = 25781
Pusher.key    = '4f4622efb83e99f6f47a'
Pusher.secret = '2236b277327a3eabde01'

require 'smtp_tls'

ActionMailer::Base.default_content_type = "text/html"
ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.smtp_settings = {
  :address => "localhost",
  :port => 587,
  :authentication => :login,
  :domain => "shark-soft.com.br",
  :user_name => "arsky3",
  :password => "vianna123"
}

ExceptionNotification::Notifier.exception_recipients = %w(gianpaulosoares@gmail.com)
ExceptionNotification::Notifier.sender_address = %("Application Error" <notificacao@shark-soft.com.br>)
ExceptionNotification::Notifier.email_prefix = "[TurcoWeb] "

