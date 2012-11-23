class Role < ActiveRecord::Base
  acts_as_authorization_role
end

class User < ActiveRecord::Base
  acts_as_authorization_subject
end

