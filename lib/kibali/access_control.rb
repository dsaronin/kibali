module Kibali
  class AccessControl < Struct.new( :role_control_hash )

# #############################################################################
# #############################################################################

# ------------------------------------------------------------------------------
# EXCEPTION: 
     # Kibali::AccessDenied -- execution denied
     # Kibali::SyntaxException -- unexpected limit_type

     # ---------------------------------------------------------------------------------
     # possible states and resultant handlings
     #   limit_type           action_list                  permitted handling
     # ---------------------------------------------------------------------------------
     #  :allow, :to, :only    [] empty, action matched     permitted
     #                           action not matched        denied
     #
     #   :deny, :except       [] empty, action matched     denied
     #                           action not matched        permitted
     #
     # ---------------------------------------------------------------------------------
 # ------------------------------------------------------------------------------
  def before( controller )

     my_role = current_user.get_role.name.to_sym

         # if current_user's role not present; check if anonymous is
     unless self.role_control_hash.member?( my_role )
        # here if current_user's role not specificied in control list

        if self.role_control_hash.member?( :anonymous )  # if anonymous is...
           my_role = :anonymous    # ...then handle anonymously
        else   # unauthorized access of controller
           raise Kibali::AccessDenied 
        end   # if..then..else anonymous check

     end   # unless current_user has a role to be checked

     expected_action = action_name.to_sym  # action being attempted

         # now check the action_hash for action access
         # shown as a loop, but only the first entry is meaningful
     self.role_control_hash[my_role].each do |limit_type, action_list|

        permitted = ( action_list.empty? || action_list.include?( expected_action ) )
        
        case limit_type
           when :allow, :to, :only then  permitted
           when :deny, :except then permitted = !permitted
        else
           raise Kibali::SyntaxError, "Unrecognized access_control limit_type: #{limit_type}"
        end  # case

        raise Kibali::AccessDenied unless permitted
        break   # always break the loop at success

     end  # do check if role

     return true
  end

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
    
  private

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
  
# #############################################################################
# #############################################################################
  end
end 
