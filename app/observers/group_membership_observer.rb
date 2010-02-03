class GroupMembershipObserver < ActiveRecord::Observer
  
  def after_create(group_membership)
    Event.create(:body => "#{group_membership.user.name} joined group #{group_membership.group.name}", :class_type => GroupMembership.to_s)
  end
  
  def after_destroy(group_membership)
    Event.create(:body => "#{group_membership.user.name} left group #{group_membership.group.name}", :class_type => GroupMembership.to_s)
  end
  
end
