ActionController::Routing::Routes.draw do |map|
  
  map.resource :user_session
  map.resource :account, :controller => "users"
  
  map.resources :projects
  map.resources :users
  
  map.root :controller => 'projects', :action => 'index'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
