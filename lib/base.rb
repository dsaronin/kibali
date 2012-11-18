module Kibali
  module Base

    def self.included(base)
      base.extend ClassMethods
    end

# #############################################################################
# #############################################################################
    module ClassMethods

# ------------------------------------------------------------------------
# acts_as_authorization_subject -- designates model to be user subject
# ------------------------------------------------------------------------
   def acts_as_authorization_subject(options = {})

     assoc      = options[:association_name] || Kibali::config[:default_association_name]
     role       = options[:role_class_name]  || Kibali::config[:default_role_class_name]
     join_table = options[:join_table_name]  || Kibali::config[:default_join_table_name]

     has_and_belongs_to_many assoc, :class_name => role, :join_table => join_table

     cattr_accessor :_auth_role_class_name, :_auth_subject_class_name, :_auth_role_assoc_name

     self._auth_role_class_name = role
     self._auth_subject_class_name = self.to_s
     self._auth_role_assoc_name = assoc

     include Kibali::SubjectExtensions

   end

# ------------------------------------------------------------------------
# @example
#   class Role < ActiveRecord::Base
#     acts_as_authorization_role
#   end
#
# @see Kibali::ModelExtensions::Subject#has_role!
# @see Kibali::ModelExtensions::Subject#has_role?
# @see Kibali::ModelExtensions::Subject#has_no_role!
# @see Kibali::ModelExtensions::Object#accepts_role!
# @see Kibali::ModelExtensions::Object#accepts_role?
# @see Kibali::ModelExtensions::Object#accepts_no_role!
# ------------------------------------------------------------------------
   def acts_as_authorization_role(options = {})
      subject = options[:subject_class_name] || Kibali::config[:default_subject_class_name]
      join_table = options[:join_table_name] || Kibali::config[:default_join_table_name]

      has_and_belongs_to_many   subject.demodulize.tableize.to_sym,
                                :class_name => subject, :join_table => join_table

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
