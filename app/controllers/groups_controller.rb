class GroupsController < ApplicationController
  before_filter :require_user
  
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
    @group = Group.find(params[:id])
  end
  
  def join
    @group = Group.find(params[:id])
    @group.members << current_user unless @group.members.include?(current_user)
    flash[:notice] = "You successfully joined this group."
    redirect_to @group
  end
end
