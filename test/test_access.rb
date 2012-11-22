require 'ctlr_helper'

require 'empty_controller'

# Re-raise errors caught by the controller.
class EmptyController; def rescue_action(e) raise e end; end


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


 
end # context

end # class test
