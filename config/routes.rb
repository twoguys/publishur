ActionController::Routing::Routes.draw do |map|

  map.resources :users
  map.resources :user_sessions
  map.resources :groups
  
  map.signup        'signup',         :controller => 'users',               :action => 'new'
  map.signin        'signin',         :controller => 'user_sessions',       :action => 'new'
  map.signout       'signout',        :controller => 'user_sessions',       :action => 'destroy'
  
  map.dashboard     'dashboard',      :controller => 'welcome',             :action => 'dashboard'
  map.home          '',               :controller => 'welcome',             :action => 'index'
  map.root          :home
end
