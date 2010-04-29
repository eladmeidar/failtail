ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.resources :users
    admin.resources :invitation_requests
  end

  map.resource :user_session,
    :except => [:index, :edit, :update]
  map.resource :account,
    :controller => 'users',
    :except => [:index, :show, :destroy]

  map.resources :invitations,
    :only => [:new, :create]
  map.resources :invitation_requests,
    :only => [:new, :create]

  # is this realy used?
  map.resources :errors,
    :only => :index

  member = {
    :close_all_errors => :put,
    :closed           => :get,
    :reset_api_key    => :get }
  map.resources :projects,
    :shallow => true,
    :member => member do |projects|

    projects.resources :memberships,
      :except => [:index, :show]

    projects.resources :errors,
      :shallow => true,
      :only => [:show, :update] do |errors|

      errors.resources :comments,
        :only => [:create]

      errors.resources :occurences,
        :only => [:show],
        :member => {
          :backtrace   => :get,
          :environment => :get }

    end
  end

  map.reports '/reports.:format',
    :controller => 'reports',
    :action     => :create
  map.users '/users',
    :controller => 'users',
    :action     => 'index'

  map.home '/home',
    :controller => 'pages',
    :action     => 'home'
  map.root \
    :controller => 'projects',
    :action => 'index'

  map.resources :service_settings

end
