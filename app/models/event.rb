class Event < ActiveRecord::Base
  
  default_scope :order => 'id DESC'
  
  def self.per_page; 20; end
  
end