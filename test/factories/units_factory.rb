require 'factory_girl'

FactoryGirl.define do |binding|
  
  
# #############################################################################
# ************* HELPER METHODS FOR THIS FACTORY *******************************
# #############################################################################
  class << binding
    
     USERNAMES = %w(demarcus deshaun jemell jermaine jabari kwashaun musa nigel kissamu yona brenden terell treven tyrese adonys)

    # pick_name -- construct a unique user name based on sequence & world (w)
    def pick_name(n,w)
      return USERNAMES[ (n % USERNAMES.size) ] + n.to_s + "_w#{w.to_s}"
    end
    
  end  # anon class extensions
# #############################################################################
# #############################################################################


   factory :user do |f|
     f.sequence( :email ) { |n| "#{binding.pick_name(n,1)}@example.com" }
     f.sequence( :name  ) { |n| "#{binding.pick_name(n,1)}@example.com" }
   end  # user
   
   factory :role do 
     name     "lime_sublime"
   end   # 
   
#   
#   factory :team_asset do |f|
#     f.association :team
#     f.association :author
#   end
#   

end  # FactoryGirl.define
