module Kibali
  module SubjectExtensions

# #############################################################################
# #############################################################################

  
# ------------------------------------------------------------------------------
# has_role? -- returns true if subject has the given role
# ------------------------------------------------------------------------------
    def has_role?(role_name)
       self.role_objects.find_by_name(role_name.to_s)
    end
  
# ------------------------------------------------------------------------------
# has_role! -- forces subject to have the given role
# ------------------------------------------------------------------------------
      def has_role!(role_name)
        role = get_role(role_name )

        if role.nil?
          role_attrs = case object
                       when Class then { :authorizable_type => object.to_s }
                       when nil   then {}
                       else            { :authorizable => object }
                       end.merge(      { :name => role_name.to_s })

          role = self._auth_role_class.create(role_attrs)
        end

        self.role_objects << role if role && !self.role_objects.exists?(role.id)
      end

  
# ------------------------------------------------------------------------------
# has_no_role! -- foreces subject to NOT have the given role
# ------------------------------------------------------------------------------
      def has_no_role!(role_name)
        delete_role( get_role(role_name) )
      end

  
# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
      def has_roles_for?(object)
        !!self.role_objects.detect(&role_selecting_lambda(object))
      end

      alias :has_role_for? :has_roles_for?

  
# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
      def roles_for(object)
        self.role_objects.select(&role_selecting_lambda(object))
      end

  
# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
      def has_no_roles_for!(object = nil)
        roles_for(object).each { |role| delete_role(role) }
      end

  
# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
      ##
      # Unassign all roles from +self+.
      def has_no_roles!
        # for some reason simple
        #
        #   self.roles.each { |role| delete_role(role) }
        #
        # doesn't work. seems like a bug in ActiveRecord
        self.role_objects.map(&:id).each do |role_id|
          delete_role self._auth_role_class.find(role_id)
        end
      end

# #############################################################################
    private
# #############################################################################

# ------------------------------------------------------------------------------
# get_role -- returns a role obj for subject; else nil
# ------------------------------------------------------------------------------
      def get_role(role_name)
        role_name = role_name.to_s

        cond = case object
               when Class
                 [ 'name = ? and authorizable_type = ? and authorizable_id IS NULL', role_name, object.to_s ]
               when nil
                 [ 'name = ? and authorizable_type IS NULL and authorizable_id IS NULL', role_name ]
               else
                 [
                   'name = ? and authorizable_type = ? and authorizable_id = ?',
                   role_name, object.class.base_class.to_s, object.id
                 ]
               end

        self._auth_role_class.first :conditions => cond
      end

  
# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
      def delete_role(role)
        if role
          self.role_objects.delete role
          if role.send(self._auth_subject_class_name.demodulize.tableize).empty?
            role.destroy unless role.respond_to?(:system?) && role.system?
          end
        end
      end

# #############################################################################
      protected
# #############################################################################

# ------------------------------------------------------------------------------
# _auth_role_class -- retuns the Klass for the Role model
# ------------------------------------------------------------------------------
      def _auth_role_class
        self.class._auth_role_class_name.constantize
      end

# ------------------------------------------------------------------------------
# _auth_role_assoc -- returns the habtm symbol for the array of subject.roles
# ------------------------------------------------------------------------------
      def _auth_role_assoc
        self.class._auth_role_assoc_name
      end

# ------------------------------------------------------------------------------
# role_objects -- returns the habtm array of roles for the subject
# ------------------------------------------------------------------------------
      def role_objects
        send(self._auth_role_assoc)
      end
#
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
    
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
  
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# #############################################################################
# #############################################################################

  end
end
