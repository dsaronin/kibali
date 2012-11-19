module Kibali
  module Base

    def self.included(base)
      base.extend ClassMethods
    end

# #############################################################################
# @example
#   class Role < ActiveRecord::Base
#     acts_as_authorization_role
#   end
#
# @see Kibali::ModelExtensions::Subject#has_role!
# @see Kibali::ModelExtensions::Subject#has_role?
# @see Kibali::ModelExtensions::Subject#has_no_role!
# #############################################################################
    module ClassMethods

# ------------------------------------------------------------------------
# acts_as_authorization_subject -- designates model to be user subject
# ------------------------------------------------------------------------
   def acts_as_authorization_subject(options = {})

     assoc      = options[:association_name] || Kibali::config[:default_roles_collection_name]
     role       = options[:role_class_name]  || Kibali::config[:default_role_class_name]
     join_table = options[:join_table_name]  || Kibali::config[:default_join_table_name]

     has_and_belongs_to_many    assoc, :class_name => role, :join_table => join_table

     cattr_accessor :_auth_role_class_name, :_auth_subject_class_name, :_auth_role_assoc_name

     self._auth_role_class_name    = role
     self._auth_subject_class_name = self.to_s
     self._auth_role_assoc_name    = assoc

     include Kibali::SubjectExtensions

   end

# ------------------------------------------------------------------------
# ------------------------------------------------------------------------
   def acts_as_authorization_role(options = {})

     assoc      = options[:association_name]    || Kibali::config[:default_users_collection_name]
     subject    = options[:subject_class_name]  || Kibali::config[:default_subject_class_name]
     join_table = options[:join_table_name]     || Kibali::config[:default_join_table_name]

     has_and_belongs_to_many    assoc, :class_name => subject, :join_table => join_table

     cattr_accessor :_auth_role_class_name, :_auth_subject_class_name, :_auth_role_assoc_name

     self._auth_role_class_name    = self.to_s
     self._auth_subject_class_name = subject
     self._auth_role_assoc_name    = assoc

     scope :named_role, lambda { |role_name| where(["name = ?", role_name]) }

   end
  
# ------------------------------------------------------------------------
# ------------------------------------------------------------------------
  
# ------------------------------------------------------------------------
# ------------------------------------------------------------------------

# ------------------------------------------------------------------------
# ------------------------------------------------------------------------

# ------------------------------------------------------------------------
# ------------------------------------------------------------------------

    end  # module ClassMethods
# #############################################################################
# #############################################################################
    
  end  # module Base
end  # module Kibali
