class User < ActiveRecord::Base
  acts_as_authentic
  
  #acts_as_network :friends,         :through => :invites,   :conditions => ["is_accepted = ?", true]
  #acts_as_network :pending_friends, :through => :invites,   :conditions => ["is_accepted = ?", false]
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def me?
    self == current_user
  end
end