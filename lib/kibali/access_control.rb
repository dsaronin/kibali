module Kibali
  class AccessControl < Struct.new( :role_control_hash )

# #############################################################################
# #############################################################################

# ------------------------------------------------------------------------------
# EXCEPTION: 
     # Kibali::AccessDenied -- execution denied
     # Kibali::SyntaxError -- unexpected limit_type, or action_type
# #############################################################################
     # see test/app/controllers/empty_controller.rb for sample syntax

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
     # if current_user.nil?, proceed as :anonymous if so referenced in role_control_hash
     # if user's role is not referenced, proceed as :all if so referenced in role_control_hash
     # else proceed with user's role
 # ------------------------------------------------------------------------------
  def before( controller )

     if controller.current_user.nil?   # no user defined; anonymous permitted?
         
        if self.role_control_hash.member?( :anonymous )  # if anonymous is referenced, continue...
           my_role = :anonymous    # ...then handle anonymously
        else   # unauthorized access of controller
           raise Kibali::AccessDenied 
        end   # if..then..else anonymous check

     elsif !self.role_control_hash.member?( my_role = controller.current_user.get_role.name.to_sym )
         
        if self.role_control_hash.member?( :all )  # if all is referenced, continue...
           my_role = :all    # ...then handle as all
        else   # unauthorized access of controller
           raise Kibali::AccessDenied 
        end   # if..then..else anonymous check

     end   # if..elsif check for anonymous or role not allowed

     expected_action = controller.action_name.to_sym  # action being attempted

     permitted = true   # presume authorized

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

        
        unless permitted      # ... figure out the type of exception
           if action_list.any?{ |actn|  actn.class.name != "Symbol" }
              raise Kibali::SyntaxError, "all actions should be symbols"
           else
              raise Kibali::AccessDenied 
           end  # syntax checking
        end  # unless

        break   # always break the loop at success

     end  # do check if role

     return permitted
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
