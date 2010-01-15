class GroupMembershipsController < ApplicationController
  before_filter :find_group
  
  def update
    @group_membership = GroupMembership.find(params[:id])
    @group_membership.update_attribute(:accepted, true)
    redirect_to @group
  end
  
  def destroy
    @group_membership = GroupMembership.find(params[:id])
    @group_membership.destroy
    redirect_to @group
  end
  
  private
    def find_group
      @group = Group.find(params[:group_id])
    end
  
end
