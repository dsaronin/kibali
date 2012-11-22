require 'ctlr_helper'

require 'empty_controller'

# Re-raise errors caught by the controller.
class EmptyController; def rescue_action(e) raise e end; end


class EmptyControllerTest < ActionController::TestCase

context "ctlr" do

   should 'be true' do
      assert true
   end  # should do

end # context

end # class test
