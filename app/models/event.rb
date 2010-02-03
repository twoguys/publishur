class Event < ActiveRecord::Base
  
  default_scope :order => 'created_at DESC'
  
  def self.per_page; 20; end
  
end