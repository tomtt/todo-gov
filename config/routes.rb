ActionController::Routing::Routes.draw do |map|
  map.resources :lists
  map.resources :user_lists, :member => {:check_item => :post, :update_notes => :post}
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users

  map.namespace :widgets do |widget|
    # Create resources for each widget
    widget_names = Dir.glob(Rails.root.join('app', 'controllers', 'widgets', '*')).
      map { |c| File.basename(c, '_controller.rb') }
    widget_names.each do |widget_name|
      widget.resources widget_name.to_sym
    end
  end

  # Named routes
  map.login '/login', :controller => "user_sessions", :action => "new"
  map.logout '/logout', :controller => "user_sessions", :action => "destroy"

  map.root :lists

  map.connect 'pages/:action', :controller => 'pages'
end
