class GroupMembershipsController < ApplicationController
  before_filter :find_group
  before_filter :find_group_membership, :only => [:accept, :reject, :destroy]
  
  def create
    @friend = User.find_all_by_email(params[:email])
    if @friend.empty? # user does not exist in our system
      # email this address and invite them to publishur
      Notifications.deliver_invite_to_publishur(params[:email], current_user, @group, join_group_path(@group))
      flash[:notice] = "We have invited your friend to join Publishur."
    else
      @friend = @friend.first
      if @group.members.include?(@friend)
        flash[:notice] = "#{@friend.name} is already a member of your group"
      else
        @group_membership = @group.invite_existing_user(@friend)
        flash[:notice] = "#{@friend.name} was invited to your group."
      end
    end  
    redirect_to invite_group_path(@group)
  end
  
  def accept
    @group_membership.update_attribute(:state, "member")
    redirect_to @group
  end
  
  def reject
    @group_membership.update_attribute(:state, "denied")
    redirect_to @group
  end
  
  def destroy
    @group_membership.destroy
    flash[:notice] = "You have left the group."
    redirect_to dashboard_path
  end
  
  private
    def find_group
      @group = Group.find(params[:group_id])
    end
    
    def find_group_membership
      @group_membership = GroupMembership.find(params[:id])
    end
  
end