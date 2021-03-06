
require File.dirname(__FILE__) + '/kibali/base'
require File.dirname(__FILE__) + '/kibali/control'
require File.dirname(__FILE__) + '/kibali/subject_extensions'
require File.dirname(__FILE__) + '/kibali/access_control'

require File.dirname(__FILE__) + '/kibali/railtie' if defined?(Rails::Railtie)

module Kibali
  @@config = {
    :default_role_class_name        => 'Role',
    :default_subject_class_name     => 'User',
    :default_subject_method         => :current_user,
    :default_roles_collection_name  => :roles,
    :default_users_collection_name  => :users,
    :default_join_table_name        => "roles_users"
  }

  mattr_reader :config

    class AccessDenied < SecurityError; end
    class EmptyRoles   < RuntimeError; end
    class SyntaxError  < ArgumentError; end


end


