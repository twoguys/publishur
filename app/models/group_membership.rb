class GroupMembership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  
  named_scope :for_user, lambda { |user| { :conditions => { :user_id => user.id } } }
  named_scope :pending, :conditions => ["accepted = ?", false]
end
