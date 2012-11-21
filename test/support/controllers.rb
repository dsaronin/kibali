class ApplicationController < ActionController::Base
  rescue_from Kibali::AccessDenied do |e|
    render :text => 'AccessDenied'
  end
end

class EmptyController < ApplicationController
  attr_accessor :current_user
  before_filter :set_current_user

  [:index, :show, :new, :edit, :update, :delete, :destroy].each do |act|
    define_method(act) { render :text => 'OK' }
  end

  private

  def set_current_user
    if params[:user]
      self.current_user = params[:user]
    end
  end
end

