ActionController::Routing::Routes.draw do |map|
  map.resources :lists
  map.resources :user_lists, :member => {:check_item => :post, :update_notes => :post}
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users

  map.namespace :widgets do |widget|
    widget.resources :find_your_nearest_gp
  end

  # Named routes
  map.login '/login', :controller => "user_sessions", :action => "new"
  map.logout '/logout', :controller => "user_sessions", :action => "destroy"

  map.root :lists

  map.connect 'pages/:action', :controller => 'pages'
end
