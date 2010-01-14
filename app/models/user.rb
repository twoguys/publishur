class User < ActiveRecord::Base
  acts_as_authentic
  
  #acts_as_network :friends,         :through => :invites,   :conditions => ["is_accepted = ?", true]
  #acts_as_network :pending_friends, :through => :invites,   :conditions => ["is_accepted = ?", false]
  
  has_many :groups,            :through    => :group_memberships, :conditions => ["accepted = ?", true]
  has_many :group_memberships
  has_many :messages
  has_many :subscriptions
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def me?
    self == current_user
  end
  
  def paying?
    self.account_type != "free"
  end
end