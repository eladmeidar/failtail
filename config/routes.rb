ActionController::Routing::Routes.draw do |map|
  
  map.resource :user_session, :only => [:new, :create, :destroy]
  map.resource :account, :only => [:new, :edit, :create, :update], :controller => 'users'
  map.resources :invitations, :only => [:new, :create]
  
  map.resource :reports, :only => :create
  map.resources :errors, :only => :index
  map.resources :projects, :shallow => true do |projects|
    projects.resources :memberships, :only => [:new, :create, :edit, :update, :destroy]
    projects.resources :errors, :shallow => true, :only => [:show, :update] do |errors|
      errors.resources :occurences, :only => [:show],
        :member => { :backtrace => :get, :environment => :get }
    end
  end
  
  map.home 'home', :controller => 'pages', :action => 'home'
  map.root :controller => 'projects', :action => 'index'
  
end
