class WelcomeController < ApplicationController
  before_filter :require_user, :only => [:dashboard]
  
  def index
    nav :home
  end
  
  def dashboard
    nav :dashboard
    @groups = current_user.groups
    @requested_memberships = current_user.group_memberships.requested(:include => :group)
    @invited_memberships = current_user.group_memberships.invited(:include => :group)
    @messages = current_user.my_recent_messages_per_group
    @others_messages = current_user.newest_message_per_group
  end

  def tour
    nav :tour
  end
  
  def pricing
    nav :pricing
  end
end
