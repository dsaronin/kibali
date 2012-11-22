class ApplicationController < ActionController::Base
  attr_accessor :current_user
  before_filter :set_current_user

  rescue_from Kibali::AccessDenied do |e|
    render :text => 'AccessDenied'
  end

  private

  def set_current_user
    if params[:user]
      self.current_user = User.find params[:user]
    end
  end
end
