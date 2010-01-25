class Group < ActiveRecord::Base
  has_many :users,             :through => :group_memberships
  has_many :pending_members,   :through => :group_memberships, :source => :user,  :conditions => ["group_memberships.accepted = ?", false]
  has_many :members,           :through => :group_memberships, :source => :user,  :conditions => ["group_memberships.accepted = ?", true] 
  has_many :admins,            :through => :group_memberships, :source => :user,  :conditions => ["group_memberships.admin = ?", true]
  has_many :group_memberships
  has_many :messages, :order => 'created_at DESC'
  has_many :subscriptions
  
  accepts_nested_attributes_for :subscriptions, :allow_destroy => true
  
  def to_param
    "#{id}-#{name.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  def admin?(user)
    self.admins.include?(user)
  end
  
  def deliver_message(message)
    self.subscriptions.each { |sub| sub.deliver(message) }
  end
  
  def under_limit?(user)
    self.subscriptions.for_user(user).count < 5
  end
  
end
