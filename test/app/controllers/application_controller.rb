class ApplicationController < ActionController::Base
  attr_accessor :my_current_user

#   rescue_from Kibali::AccessDenied do |e|
#     render :text => 'AccessDenied'
#   end

  #protected

  def set_current_user
    if params[:user].blank?
       self.my_current_user = nil
    else
      self.my_current_user = User.find params[:user]
    end
  end

  def current_user
    self.my_current_user
  end


end   # class
