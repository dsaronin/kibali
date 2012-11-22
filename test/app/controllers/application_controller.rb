class ApplicationController < ActionController::Base
  rescue_from Kibali::AccessDenied do |e|
    render :text => 'AccessDenied'
  end
end
