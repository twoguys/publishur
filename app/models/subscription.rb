class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  named_scope :for_user, lambda { |user| { :conditions => { :user_id => user.id } } }
  named_scope :for_everyone_but, lambda { |user| { :conditions => ["user_id <> ?", user.id] } }
  
  TYPES = ['email', 'AIM', 'GoogleTalk', 'SMS'].freeze
  
  validates_presence_of :contact_type
  validates_inclusion_of :contact_type, :in => TYPES
  validates_presence_of :contact_info
  
  def self.types
    TYPES
  end
end
