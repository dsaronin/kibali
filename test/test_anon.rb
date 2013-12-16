require 'ctlr_helper'

require 'anon_controller'

class AnonControllerTest < ActionController::TestCase

context "ctlr" do

    setup do
      @demarcus = FactoryGirl.create( :user )
      @deshaun =  FactoryGirl.create( :user )
    end

    teardown do
       User.all.each {|x| x.destroy }
       Role.all.each {|x| x.destroy }
    end

   should 'permit admin access _ implicit all 2' do 
     @demarcus.has_role!( :admin )

     get :index, :user => @demarcus.id.to_s
     assert_response :success

     get :show, :user => @demarcus.id.to_s
     assert_response :success

   end  # should do


   should 'permit anonymous only access to index not show' do 

     get :index, :user => ""
     assert_response :success

     assert_raise( Kibali::AccessDenied ) do
        get :show, :user => ""
     end  #  block

   end  # should do


   should 'unspecified access to everything except edit' do 
     @deshaun.has_role!( :manager )

     get :index, :user => @deshaun.id.to_s
     assert_response :success
     get :show, :user => @deshaun.id.to_s
     assert_response :success

     assert_raise( Kibali::AccessDenied ) do
        get :edit, :user => @deshaun.id.to_s
     end  #  block


   end  # should do

 
end # context

end # class test
