class EmptyController < ApplicationController
  [:index, :show, :new, :edit, :update, :delete, :destroy].each do |act|
    define_method(act) { render :text => 'OK' }
  end
end

