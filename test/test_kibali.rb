require 'helper'

class TestKibali < Test::Unit::TestCase

 context "a user" do

    setup do
      @demarcus = FactoryGirl.create( :user )
      @deshaun =  FactoryGirl.create( :user )
    end

    teardown do
       User.destroy_all
       Role.destroy_all
    end


    should "raise exception if no roles" do
       assert_raise( Kibali::EmptyRoles ) do
         @demarcus.get_role()
       end  #  block
    end

   should "be assigned a role" do
      assert_not_equal  @deshaun,@demarcus
      assert_difference( 'Role.count' ) do
         @demarcus.has_role!( :admin )
      end  # do count diff
      assert @demarcus.has_role?( :admin )
      assert !@demarcus.has_role?( :wildblue )
   end  # do should

   should "get role for all cases" do
      @demarcus.has_role!( :admin )
      admin_role_list = Role.where( :name => "admin" ).all
      assert_equal  1,admin_role_list.size
      assert_equal  admin_role_list.first, @demarcus.get_role( :admin )
      assert_equal  admin_role_list.first, @demarcus.get_role( )

      assert_nil  @demarcus.get_role( :wildblue )

   end  # do should

   should "not get created the same role" do
      @demarcus.has_role!( :admin )
      assert_no_difference( 'Role.count' ) do
         @demarcus.has_role!( :admin )
      end  # do count diff
      assert @demarcus.has_role?( :admin )
      assert_equal  1,@demarcus.roles.size
       
   end  # do should

   should "get same role as another user" do
      @demarcus.has_role!( :admin )

      assert_no_difference( 'Role.count' ) do
         @deshaun.has_role!( :admin )
      end  # do count diff

      assert @demarcus.has_role?( :admin )
      assert @deshaun.has_role?( :admin )

      assert_equal @demarcus.get_role(:admin),@deshaun.get_role(:admin)

   end  # do should

   should "get different role as another user" do
      @demarcus.has_role!( :admin )

      assert_difference( 'Role.count' ) do
         @deshaun.has_role!( :manager )
      end  # do count diff

      assert  @demarcus.has_role?( :admin )
      assert !@deshaun.has_role?(  :admin )
      assert  @deshaun.has_role?(  :manager )
      assert !@demarcus.has_role?( :manager )

      assert_not_equal @demarcus.get_role(:admin),@deshaun.get_role(:manager)
      assert_equal  1,@demarcus.roles.size
      assert_equal  1,@deshaun.roles.size

   end  # do should


   should "remove a singleton role" do
      @demarcus.has_role!( :admin )
      assert_no_difference( 'Role.count' ) do
         @demarcus.remove_role!( :admin )
      end  # do count diff
      assert  @demarcus.roles.empty?
      assert_raise( Kibali::EmptyRoles ) do
        @demarcus.get_role( :admin )
      end  #  block
     end  # do should


   should "remove someone elses role but not mine" do
      @demarcus.has_role!( :admin )
      @deshaun.has_role!( :manager )
      @demarcus.remove_role!( :admin )
      assert  @demarcus.roles.empty?
      assert_equal  1,@deshaun.roles.size
      assert  @deshaun.has_role?(  :manager )
   end  # do should

 # _____________________________________________________________
 end   # context

 context "a role" do

    setup do
      @admin   =  FactoryGirl.create( :role,  name: "admin" )
      @manager =  FactoryGirl.create( :role,  name: "manager")
    end

    teardown do
       User.destroy_all
       Role.destroy_all
    end

   should "not be same as another" do
      assert_not_equal  @admin,@manager
   end  # do should

   should "find named_role" do
      assert_equal  2,Role.count
      assert_equal  @manager,Role.named_role( :manager ).first
   end  # do should


   should "not find named_role" do
      assert_nil  Role.named_role( :wildblue ).first
   end  # do should

 # _____________________________________________________________
 end   # context
 
end
