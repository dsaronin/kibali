require 'kibali'
require 'rails'

module Kibali
  class Railtie < Rails::Railtie
    initializer :after_initialize do
 
        ActiveRecord::Base.send(:include, Kibali::Base)
        ActionController::Base.send(:include, Kibali::Control)
        
    end

#     rake_tasks do
#       load 'kibali/tasks.rb'
#     end
  end
end
