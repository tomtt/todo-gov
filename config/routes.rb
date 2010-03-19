ActionController::Routing::Routes.draw do |map|
  map.resources :lists
  map.resources :user_lists
  map.resource :user_session

  # Named routes
  map.login '/login', :controller => "user_sessions", :action => "new"
  map.logout '/logout', :controller => "user_sessions", :action => "destroy"

  map.root :lists
end
