class GroupsController < ApplicationController
  before_filter :require_user
  before_filter :find_group, :only => [:show, :join, :forwarding, :update]
  
  def index
    nav :groups
    if !params[:q].blank?
      @groups = Group.paginate(:page => params[:page] || 1, :conditions => ["name LIKE ?", "%#{params[:q]}%"])
    else
      @groups = Group.paginate(:page => params[:page] || 1)
    end
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.create(params[:group])
    if @group.save
      @group.group_memberships << GroupMembership.new(:user => current_user, :admin => true)
      redirect_to @group
    else
      render 'new'
    end
  end
  
  def show
    @membership = @group.group_memberships.for_user(current_user).first
  end
  
  def join
    @group.members << current_user if !@group.members.include?(current_user) && @group.public?
    flash[:notice] = "You successfully joined this group."
    redirect_to @group
  end
  
  def forwarding
    @membership = @group.group_memberships.for_user(current_user).first
    @subscriptions = @group.subscriptions.for_user(current_user)
  end
  
  def update
    @group.update_attributes(params[:group])
    flash[:notice] = "Message forwarding updated"
    redirect_to @group
  end
  
  private
    def find_group
      @group = Group.find(params[:id])
    end
end