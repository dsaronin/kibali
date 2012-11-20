require 'helper'

class TestKibali < Test::Unit::TestCase

 context "a user" do

    setup do
      @user = FactoryGirl.create( :user )
    end

    should "raise exception if no roles" do
       assert_raise( Kibali::EmptyRoles ) do
         @user.get_role()
       end  #  block
    end



 end   # context

end
