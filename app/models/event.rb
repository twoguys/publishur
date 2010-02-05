class Event < ActiveRecord::Base
  
  default_scope :order => 'created_at DESC'
  
  def self.per_page; 20; end
  
  def self.send_summary(time)
    @events = Event.find(:all, :conditions => ["created_at > ? and created_at < ?", time - 24.hours, time])
    
  end
  
end