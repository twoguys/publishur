class WelcomeController < ApplicationController
  before_filter :require_user, :only => [:dashboard]
  
  def index
    nav :home
  end
  
  def dashboard
    nav :dashboard
    @groups = current_user.groups
  end
  
  def pricing
    nav :pricing
  end
end
