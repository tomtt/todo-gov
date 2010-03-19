ActionController::Routing::Routes.draw do |map|
  # Resources
  map.resources :lists
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users

  # Named routes
  map.login '/login', :controller => "user_sessions", :action => "new"
  map.logout '/logout', :controller => "user_sessions", :action => "destroy"
end
