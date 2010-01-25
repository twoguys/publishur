class User < ActiveRecord::Base
  acts_as_authentic
  
  #acts_as_network :friends,         :through => :invites,   :conditions => ["is_accepted = ?", true]
  #acts_as_network :pending_friends, :through => :invites,   :conditions => ["is_accepted = ?", false]
  
  has_many :groups, :through => :group_memberships, :conditions => ["accepted = ?", true]
  has_many :group_memberships
  has_many :messages, :order => "created_at DESC"
  has_many :subscriptions
  #has_many :owned_groups, :class_name => "Group", :foreign_key => "user_id"
  
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
  
  def my_recent_messages_per_group
    messages = {}
    self.messages.each do |m|
      if messages.has_key?(m.group_id)
        messages[m.group_id] = m if m.created_at > messages[m.group_id].created_at
      else
        messages[m.group_id] = m
      end
    end
    return messages.values
  end
  
  def newest_message_per_group
    group_messages = []
    self.groups(:include => :messages).each do |g|
      message = nil
      g.messages.each do |m|
        if m.user != self
          if message.nil?
            message = m
          else  
            message = m if m.created_at > message.created_at
          end
        end
      end
      group_messages += [message] unless message.nil?
    end
    return group_messages
  end
end