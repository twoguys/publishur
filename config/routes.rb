ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resources :user_sessions
  map.resources :groups,
    :member => { :join => :get } do |group|
    group.resources :messages
  end
  
  map.signup          'signup',           :controller => 'users',               :action => 'new'
  map.signup_pro      'signup/pro',       :controller => 'users',               :action => 'new_pro'
  map.signup_ultimate 'signup/ultimate',  :controller => 'users',               :action => 'new_ultimate'
  
  map.signin        'signin',         :controller => 'user_sessions',       :action => 'new'
  map.signout       'signout',        :controller => 'user_sessions',       :action => 'destroy'
  
  map.dashboard     'dashboard',      :controller => 'welcome',             :action => 'dashboard'
  map.pricing       'pricing',        :controller => 'welcome',             :action => 'pricing'
  map.settings      'settings',       :controller => 'users',               :action => 'edit'
  map.home          '',               :controller => 'welcome',             :action => 'index'
  map.root          :home
end