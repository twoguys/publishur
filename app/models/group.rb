class Group < ActiveRecord::Base
  has_many :users,             :through => :group_memberships
  has_many :pending_members,   :through => :group_memberships, :source => :user,  :conditions => ["group_memberships.accepted = ?", false]
  has_many :members,           :through => :group_memberships, :source => :user,  :conditions => ["group_memberships.accepted = ?", true] 
  has_many :admins,            :through => :group_memberships, :source => :user,  :conditions => ["group_memberships.admin = ?", true]
  has_many :group_memberships, :dependent => :destroy
  has_many :messages, :order => 'created_at DESC', :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :short_name
  
  #belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  
  #after_create :create_free_spreedly_plan
  
  accepts_nested_attributes_for :subscriptions, :allow_destroy => true
  
  MEMBER_LEVELS = {"free" => 5, "team" => 20, "business" => 50}.freeze
  
  def to_param
    "#{id}-#{name.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  def admin?(user)
    self.admins.include?(user)
  end
  
  def deliver_message(message)
    self.subscriptions.each { |sub| sub.deliver(message) }
  end
  
  def under_subscription_limit?(user)
    self.subscriptions.for_user(user).count < 5
  end
  
  def under_user_limit?
    self.members.count <= self.level 
  end
  
  def free?
    self.level == MEMBER_LEVELS["free"]
  end
  
  def team?
    self.level == MEMBER_LEVELS["team"]
  end
  
  def business?
    self.level == MEMBER_LEVELS["business"]
  end
  
  def refresh_from_spreedly
    sub = RSpreedly::Subscriber.find(self.id)
    self.update_attributes(:active => sub.active, :spreedly_token => sub.token)
    rescue ActiveResource::ResourceNotFound
      self.update_attribute(:active, false)
  end
  
  private
  
  # Create a new account on spreedly for the free plan
  def create_free_spreedly_plan
    sub = RSpreedly::Subscriber.new(:customer_id => self.id, :email => self.owner.email)
    sub.save
    self.update_attributes(:spreedly_token => sub.token, :spreedly_plan => ENV['SPREEDLY_FREE_PLAN'] || 'free')
  end
  
end
