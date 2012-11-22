ENV["RAILS_ENV"] = "test"

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'test/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# require "rails_app/config/environment"
# require "rails/test_help"

require 'rails'
require 'active_support'
require 'active_record'
require 'action_controller'
require 'rails/test_help'
require 'shoulda'
require 'factory_girl'

require "action_controller/railtie"
require "rails/test_unit/railtie"

require 'kibali'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'test.sqlite3')
ActiveRecord::Base.send(:include, Kibali::Base)

require 'support/models'
load 'support/schema.rb'

#Logger = ActiveRecord::Base.logger

class Test::Unit::TestCase
 
   FactoryGirl.find_definitions
   include FactoryGirl::Syntax::Methods
   include ActiveSupport::Testing::Assertions
   
end

root = File.expand_path(File.dirname(__FILE__))
 
# Define the application and configuration
module TestKibali
  class Application < ::Rails::Application
    # configuration here if needed
    config.active_support.deprecation = :stderr
  end
end

# Initialize the application
TestKibali::Application.initialize!

# ActionController::Routing::Routes.draw do |map|
#   map.connect ":controller/:action/:id"
# end

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActionController::Base.logger = ActiveRecord::Base.logger
ActiveRecord::Base.silence { ActiveRecord::Migration.verbose = false }

class ActiveSupport::TestCase

  # Add more helper methods to be used by all tests here...

end

