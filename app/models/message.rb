class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  validates_presence_of :body
end
