class EmptyController < ApplicationController
  before_filter :set_current_user
#  before_filter :trace_setup

   control_hash = {
       :admin1   => { } ,
       :admin2   => { :allow => [] },
       :manager1 => { :allow => [ :index, :edit ] },
       :denier1  => { :deny  => [ ] },
       :denier2  => { :deny  => [ :index, :edit ] },
       :error1   => { :wild  => [ :index ] },
       :error2   => { 'allow'  => [ :index ] },
       :error3   => { :allow  => [ :index, 'show' ] },
       :error4   => { 'allow'  => :index }
       
   }

   access_control control_hash


  [:index, :show, :new, :edit, :update, :delete, :destroy].each do |act|
    define_method(act) { render :text => 'OK' }
  end

protected

  def trace_setup
      puts ">>>>>> trace/self: #{self.class.name} <<<<<<"
      puts ">>>>>> trace/current_user: #{self.respond_to?(:current_user).to_s} <<<<<<"
      puts ">>>>>> trace/method_defined: #{EmptyController.method_defined?(:current_user).to_s} <<<<<<"
      puts ">>>>>> trace/user is: #{current_user.name.to_s} <<<<<<"
  end

end

