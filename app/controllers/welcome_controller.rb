class WelcomeController < ApplicationController
  before_filter :require_user, :only => [:dashboard]
  
  def index
    nav :home
  end
  
  def dashboard
    nav :dashboard
    @groups = current_user.groups
    @pending_memberships = current_user.group_memberships.pending(:include => :group)
  end
  
  def pricing
    nav :pricing
  end
end
