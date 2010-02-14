class GroupMembership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  
  named_scope :for_user, lambda { |user| { :conditions => { :user_id => user.id } } }
  named_scope :requested, :conditions => ["state = ?", "requested"]
  named_scope :invited, :conditions => ["state = ?", "invited"]
  
  def invited?
    self.state == "invited"
  end
  
  def member?
    self.state == "member"
  end
  
  def requested?
    self.state == "requested"
  end
  
  def denied?
    self.state == "denied"
  end
end
