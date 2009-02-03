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
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  
  class << self
    attr_accessor :current_user
  end
  current_user = nil
  
  def current_user
    self.class.current_user
  end
  
  def self.when_not_logged_in(&block)
    context "when not logged in" do
      current_user_is_missing
      block.call
    end
  end
end

module Thoughtbot
  module Shoulda
    class Context
      
      attr_accessor :current_user
      attr_accessor :current_user_proc
      
      def current_user_is_missing
        current_user_is { false }
      end
      
      def current_user_is(&blk)
        self.current_user_proc = blk
      end
      
      def run_parent_setup_blocks_with_authlogic(binding)
        if self.current_user_proc and self.current_user.nil?
          self.current_user = self.current_user_proc.bind(binding).call
        end
        unless self.parent.is_a? Context
          test_unit_class.current_user = self.current_user
          binding.send(:set_session_for, self.current_user) if self.current_user
        else
          self.parent.current_user = self.current_user
        end
        run_parent_setup_blocks_without_authlogic(binding)
      end
      alias_method_chain :run_parent_setup_blocks, :authlogic
      
    end
  end
end