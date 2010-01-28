ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resources :user_sessions
  map.resources :groups,
    :member       => { :join => :get, :join_request => :get, :forwarding => :get, :toggle_lock => :get, :full => :get, :upgrade => :get },
    :collection   => { :changed => :post } do |group|
    group.resources :messages
    group.resources :subscriptions
    group.resources :group_memberships, :only => [:update, :destroy]
  end
  
  map.signup          'signup',           :controller => 'users',               :action => 'new'
  map.signup_pro      'signup/pro',       :controller => 'users',               :action => 'new_pro'
  map.signup_ultimate 'signup/ultimate',  :controller => 'users',               :action => 'new_ultimate'
  
  map.signin        'signin',         :controller => 'user_sessions',       :action => 'new'
  map.signout       'signout',        :controller => 'user_sessions',       :action => 'destroy'
  
  map.dashboard     'dashboard',      :controller => 'welcome',             :action => 'dashboard'
  map.tour          'tour',           :controller => 'welcome',             :action => 'tour'
  map.pricing       'pricing',        :controller => 'welcome',             :action => 'pricing'
  map.terms         'terms',          :controller => 'welcome',             :action => 'terms'
  map.settings      'settings',       :controller => 'users',               :action => 'edit'
  map.home          '',               :controller => 'welcome',             :action => 'index'
  
  map.namespace :admin do |admin|
    admin.resources :delayed_jobs,  :only => [:index, :show, :destroy], :collection => { :destroy_all => :delete }
    admin.resources :base,          :only => [:index]
  end
  
  map.admin 'admin', :controller => 'admin/base', :action => 'index'
  
  map.root          :home
end