class Group < ActiveRecord::Base
  has_many  :users,             :through => :group_memberships
  has_many  :pending_members,   :through => :group_memberships, :source => :user,  :conditions => ["group_memberships.accepted = ?", false]
  has_many  :members,           :through => :group_memberships, :source => :user,  :conditions => ["group_memberships.accepted = ?", true] 
  has_many  :admins,            :through => :group_memberships, :source => :user,  :conditions => ["group_memberships.admin = ?", true]
  has_many  :group_memberships
end
