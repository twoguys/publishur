ActionController::Routing::Routes.draw do |map|
  map.signup        'signup',         :controller => 'users',               :action => 'new'
  map.signin        'signin',         :controller => 'user_sessions',       :action => 'new'
  map.signout       'signout',        :controller => 'user_sessions',       :action => 'destroy'
  
  map.home          '',               :controller => 'welcome',             :action => 'index'
  map.root          :home
end
