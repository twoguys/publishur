class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  named_scope :for_user, lambda { |user| { :conditions => { :user_id => user.id } } }
  named_scope :for_everyone_but, lambda { |user| { :conditions => ["user_id <> ?", user.id] } }
  
  TYPES = ['email', 'AIM', 'GoogleTalk', 'SMS'].freeze
  
  validates_presence_of   :contact_type
  validates_inclusion_of  :contact_type, :in => TYPES
  validates_presence_of   :contact_info
  
  def self.types
    TYPES
  end
  
  def deliver(message)
    if self.contact_type == 'AIM'
      login = ENV['AIM_LOGIN'] || 'publishur'
      password = ENV['AIM_PASSWORD'] || 'b33r1sc00l'
      client = Net::TOC.new(login, password)
      client.connect
      receiver = friend = client.buddy_list.buddy_named(self.contact_info)
      receiver.send_im(message)
    else
      raise "Unknown Contact Type"
    end
  end
end
