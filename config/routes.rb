ActionController::Routing::Routes.draw do |map|
  
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :invitations
  
  map.resource :reports, :only => :create 
  map.resources :projects, :shallow => true do |projects|
    projects.resources :memberships, :only => [:new, :create, :edit, :update, :destroy]
    projects.resources :errors, :shallow => true, :only => [:show, :update] do |errors|
      errors.resources :occurences, :only => [:show],
        :member => { :backtrace => :get, :environment => :get }
    end
  end
  
  map.home 'home', :controller => 'pages', :action => 'home'
  map.root :controller => 'projects', :action => 'index'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
