class GroupsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :updated
  
  before_filter :require_user, :except => [:join]
  before_filter :find_group, :except => [:index, :new, :create]
  before_filter :allowed, :except => [:index, :new, :create, :join_request, :join, :full]
  
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
      @group.group_memberships << GroupMembership.new(:user => current_user, :admin => true, :accepted => true)
      Email.create(:group => @group, :user => current_user, :contact_info => current_user.email)
      redirect_to invite_group_path(@group)
    else
      render 'new'
    end
  end
  
  def invite
    if !@group.admin?(current_user)
      flash[:error] = "Sorry, you have to be the group admin."
      redirect_to @group
    else
      @group_membership = GroupMembership.new
    end
  end
  
  def show
    redirect_to join_group_path unless @group.members.include?(current_user)
    @membership     = @group.group_memberships.for_user(current_user).first
    @subscriptions  = @group.subscriptions.for_user(current_user)
    @messages       = @group.messages.paginate :page => params[:page] || 1
  end
  
  def destroy
    @group.destroy if @group.admin?(current_user)
    redirect_to groups_path
  end
  
  def join
    if current_user
      if @group.members.include?(current_user)
        flash[:notice] = "You're already a member of this group!"
        redirect_to @group
      elsif !@group.under_user_limit?
        redirect_to full_group_path(@group)
      else
        membership = @group.handle_user_join(current_user)
        redirect_to @group if membership.member?
      end
    else
      if session[:join_groups].is_a?(Array)
        session[:join_groups] = (session[:join_groups] + [@group.id]).uniq
      else
        session[:join_groups] = [@group.id]
      end
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
  
  # Update POST from spreedly
  def changed
    subscriber_ids = params[:subscriber_ids].split(",")
    subscriber_ids.each do |each|
      group = Group.find_by_id(each)
      group.refresh_from_spreedly if group
    end

    head(:ok)
  end
  
  def upgrade
    
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