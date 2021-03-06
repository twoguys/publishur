class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.ignore_blank_passwords = Proc.new { |user| user.invited? }
  end
  
  #acts_as_network :friends,         :through => :invites,   :conditions => ["is_accepted = ?", true]
  #acts_as_network :pending_friends, :through => :invites,   :conditions => ["is_accepted = ?", false]
  
  has_many :groups, :through => :group_memberships, :conditions => ["state = ?", "member"]
  has_many :group_memberships
  has_many :messages, :order => "created_at DESC"
  has_many :subscriptions
  #has_many :owned_groups, :class_name => "Group", :foreign_key => "user_id"
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :send_me_updates, :state
  
  def self.per_page; 25; end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def me?
    self == current_user
  end
  
  def paying?
    self.account_type != "free"
  end
  
  def invited?
    self.state == "invited"
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