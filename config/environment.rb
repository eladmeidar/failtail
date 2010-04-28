# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'factory_girl'
  config.gem 'shoulda'
  config.gem "authlogic"
  config.gem 'railsgarden-message_block', :lib => 'message_block'
  config.gem 'haml'
  config.gem 'will_paginate'
  
  config.time_zone = 'UTC'
  
  config.action_controller.session = {
    :session_key => '_errors_session',
    :secret      => '729bdf4f8affcc1dc4cd4e5d8b7c6b8fc91e5341e8a486d5203ed62679e60f0b324f707a36b60c04deb17aa4308e51ebecb440fc92bbb929cc72d87b434d8c8e'
  }
end

