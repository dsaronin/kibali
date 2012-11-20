module Kibali
  module Control

# #############################################################################
# #############################################################################
    
    def self.included(base)
      base.extend ClassMethods
    end

# #############################################################################
# #############################################################################
    module ClassMethods

       def access_control( role_control_hash, options = {} )
          before_filter  Kibali::AccessControl.new( role_control_hash ), options
       end

    end  # module ClassMethods

# #############################################################################
# #############################################################################
    
  private

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
    
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
  
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# #############################################################################
# #############################################################################

  end  # module Control
end  # module Kibali