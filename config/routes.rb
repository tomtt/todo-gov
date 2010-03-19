ActionController::Routing::Routes.draw do |map|
  map.root :lists

  map.resources :lists
  map.resources :user_lists
  map.resource :user_session

  # Named routes
  map.login '/login', :controller => "user_sessions", :action => "new"
  map.logout '/logout', :controller => "user_sessions", :action => "destroy"
end
