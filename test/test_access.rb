require 'ctlr_helper'

require 'empty_controller'

class EmptyControllerTest < ActionController::TestCase

context "ctlr" do

    setup do
      @demarcus = FactoryGirl.create( :user )
      @deshaun =  FactoryGirl.create( :user )
    end

    teardown do
       User.destroy_all
       Role.destroy_all
    end


   should 'be true' do
      assert true
   end  # should do

   should 'permit admin1 access _ implicit all' do 
     @demarcus.has_role!( :admin1 )

     get :index, :user => @demarcus.id.to_s
     assert_response :success

     get :show, :user => @demarcus.id.to_s
     assert_response :success

   end  # should do

   should 'permit admin2 access _ implicit all 2' do 
     @demarcus.has_role!( :admin2 )

     get :index, :user => @demarcus.id.to_s
     assert_response :success

     get :show, :user => @demarcus.id.to_s
     assert_response :success

   end  # should do


   should 'permit manager1 only access to index, edit' do 
     @deshaun.has_role!( :manager1 )

     get :index, :user => @deshaun.id.to_s
     assert_response :success
     get :edit, :user => @deshaun.id.to_s
     assert_response :success

     assert_raise( Kibali::AccessDenied ) do
        get :show, :user => @deshaun.id.to_s
     end  #  block

   end  # should do


   should 'deny denier1 access to everything' do 
     @deshaun.has_role!( :denier1 )

     assert_raise( Kibali::AccessDenied ) do
        get :show, :user => @deshaun.id.to_s
     end  #  block

     assert_raise( Kibali::AccessDenied ) do
        get :index, :user => @deshaun.id.to_s
     end  #  block

     assert_raise( Kibali::AccessDenied ) do
        get :edit, :user => @deshaun.id.to_s
     end  #  block

   end  # should do


   should 'deny denier2 access to index edit' do 
     @deshaun.has_role!( :denier2 )

     get :show, :user => @deshaun.id.to_s
     assert_response :success

     assert_raise( Kibali::AccessDenied ) do
        get :index, :user => @deshaun.id.to_s
     end  #  block

     assert_raise( Kibali::AccessDenied ) do
        get :edit, :user => @deshaun.id.to_s
     end  #  block

   end  # should do



   should 'deny others all access ' do 
     @deshaun.has_role!( :wildblue )

     assert_raise( Kibali::AccessDenied ) do
        get :index, :user => @deshaun.id.to_s
     end  #  block

   end  # should do


   should 'error unknown limit type ' do 
     @deshaun.has_role!( :error1 )

     assert_raise( Kibali::SyntaxError ) do
        get :index, :user => @deshaun.id.to_s
     end  #  block

   end  # should do


   should 'error unknown limit type non symbol' do 
     @deshaun.has_role!( :error2 )

     assert_raise( Kibali::SyntaxError ) do
        get :index, :user => @deshaun.id.to_s
     end  #  block

   end  # should do


   should 'error unknown action ' do 
     @deshaun.has_role!( :error3 )

     assert_raise( Kibali::SyntaxError ) do
        get :show, :user => @deshaun.id.to_s
     end  #  block

   end  # should do



 
end # context

end # class test
