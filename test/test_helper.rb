ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

require 'shoulda_action_mailer'
require 'authlogic/testing/test_unit_helpers'
require 'factory_girl'
Dir.glob(File.join(Rails.root, 'test/factories/*_factory.rb')).each do |file|
  require file
end

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false


end
