class GroupMembershipObserver < ActiveRecord::Observer
  
  def after_create(group_membership)
    Event.create(:body => "#{group_membership.user.name} joined group #{group_membership.group.name}", :class_type => GroupMembership.to_s)
    Notifications.deliver_request_to_join(group_membership) if group_membership.state == "requested"
  end
  
  def after_destroy(group_membership)
    Event.create(:body => "#{group_membership.user.name} left group #{group_membership.group.name}", :class_type => GroupMembership.to_s)
  end
  
end
