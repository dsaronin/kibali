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

   should "be assigned a role" do
      assert_difference( 'Role.count' ) do
         @user.has_role!( :admin )
      end  # do count diff
      assert @user.has_role?( :admin )
      assert !@user.has_role?( :wildblue )
   end  # do should



 end   # context

end
