class GroupsController < ApplicationController
  before_filter :require_user
  before_filter :find_group, :except => [:index, :new, :create]
  before_filter :allowed, :except => [:index, :new, :create, :join_request, :join]
  
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
    @membership     = @group.group_memberships.for_user(current_user).first
    @subscriptions  = @group.subscriptions.for_user(current_user)
    @messages       = @group.messages.paginate :page => params[:page] || 1
  end
  
  def join
    if @group.members.include?(current_user)
      redirect_to @group
    elsif @group.public?
      @group.group_memberships << GroupMembership.new(:user => current_user, :accepted => true)
      redirect_to @group
    end
  end
  
  def join_request
    if @group.members.include?(current_user)
      flash[:notice] = "You are already a member!"
      redirect_to @group
    elsif @group.public?
      @group.members << current_user
      flash[:notice] = "You successfully joined this group."
      redirect_to @group
    elsif !@group.pending_members.include?(current_user)
      @group.group_memberships << GroupMembership.new(:user => current_user, :accepted => false)
      flash[:notice] = "Your request has been saved."
      redirect_to join_group_path(@group)
    else
      redirect_to join_group_path(@group)
    end
  end
  
  def forwarding
    @membership = @group.group_memberships.for_user(current_user).first
    @subscriptions = @group.subscriptions.for_user(current_user)
    @subscription = @group.subscriptions.new(:user => current_user)
  end
  
  def toggle_lock
    @group.toggle!(:public) if @group.admin?(current_user)
    redirect_to @group
  end
  
  def edit
  end
  
  def update
    @group.update_attributes(params[:group])
    flash[:notice] = "Group updated"
    redirect_to @group
  end
  
  private
    def find_group
      @group = Group.find(params[:id], :include => [:users, :group_memberships])
    end
    
    def allowed
      if !@group.public? && !@group.members.include?(current_user)
        redirect_to join_group_path(@group)
      end
    end
end