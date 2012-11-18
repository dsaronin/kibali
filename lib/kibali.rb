
require File.dirname(__FILE__) + '/kibali/base'
require File.dirname(__FILE__) + '/kibali/control'

require File.dirname(__FILE__) + '/kibali/railtie' if defined?(Rails::Railtie)

module Kibali
  @@config = {
    :default_role_class_name    => 'Role',
    :default_subject_class_name => 'User',
    :default_subject_method     => :current_user,
    :default_association_name   => :role_objects
  }

  mattr_reader :config
end


