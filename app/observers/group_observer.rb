class GroupObserver < ActiveRecord::Observer
  
  def after_create(group)
    Event.create(:body => "#{group.group_memberships.first.user.name} create group #{group.name}", :class_type => Group.to_s)
  end
  
  def after_destroy(group)
    Event.create(:body => "#{group.group_memberships.first.user.name} deleted group #{group.name}", :class_type => Group.to_s)
  end
  
end
