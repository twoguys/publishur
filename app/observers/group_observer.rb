class GroupObserver < ActiveRecord::Observer
  
  def after_create(group)
    Event.create(:body => "Group #{group.name} created", :class_type => Group.to_s)
  end
  
  def after_destroy(group)
    Event.create(:body => "Group #{group.name} deleted", :class_type => Group.to_s)
  end
  
end
