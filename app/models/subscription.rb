class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  named_scope :for_user, lambda { |user| { :conditions => { :user_id => user.id } } }
  named_scope :for_everyone_but, lambda { |user| { :conditions => ["user_id <> ?", user.id] } }
  
  TYPES = ['Email', 'AIM', 'JabberMessage', 'SMS'].freeze
  
  #validates_presence_of   :contact_type
  #validates_inclusion_of  :contact_type, :in => TYPES
  validates_presence_of   :contact_info
  
  attr_accessor :message
  
  def self.types
    TYPES
  end
  
  def deliver(message)
    self.message = message
    #Delayed::Job.enqueue("Transport::#{self.contact_type}".constantize.new(:receiver => self.contact_info, :message => message.body, :group => self.group.name))
    Delayed::Job.enqueue(self)
    
    # Uncomment to send messages without using DJ
    # transport = ("Transport::#{self.contact_type}".constantize.new(:receiver => self.contact_info, :message => message.body)
    # transport.perform
  end
  
  def perform
    raise "Must implement perform method!"
  end
   
   
end
