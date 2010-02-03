class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  named_scope :for_user, lambda { |user| { :conditions => { :user_id => user.id } } }
  named_scope :for_everyone_but, lambda { |user| { :conditions => ["user_id <> ?", user.id] } }
  
  validates_presence_of   :contact_info
  
  attr_accessor :contact_type
  
  TYPES = { 'Email' => 'Email', 'AIM' => 'AIM', 'JabberMessage' => 'GoogleTalk', 'Tweet' => 'Twitter', 'PostHook' => 'HTTP Post' }
  
  def self.types
    TYPES
  end
  
  def print_type
    return "#{TYPES[self.class.to_s]}"
  end
  
  def print_description
    # handled by subclasses
  end
  
  def contact_type
    "#{self.class}"
  end
  
  def deliver(message)
    raise "Must implement deliver method!"
  end
  
  # :to
  # :from
  # :message
  # :group
  # :type
  def quick_deliver(opts={})
    raise "Must implement quick deliver method!"
  end  
  # def deliver(message)
  #     self.message = message
  #     Delayed::Job.enqueue(self)
  #     
  #     # Uncomment to send messages without using DJ
  #     # self.perform
  #   end
  
  # def perform
  #     raise "Must implement perform method!"
  #   end 
   
end
