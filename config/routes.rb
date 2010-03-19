ActionController::Routing::Routes.draw do |map|
  map.resources :lists
  map.resources :user_lists
  map.root :lists
end
