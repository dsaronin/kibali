TestKibali::Application.routes.draw do

  root :to => "empty#index"
  
  match ':controller(/:action(/:id(.:format)))', via: [:get, :post]
end  # draw
