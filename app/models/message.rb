class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  validates_presence_of :body
  
  def deliver_subscriptions
    #subs = self.group.subscriptions.for_user(self.user)
    require 'pp'
    pp self.group # works
    # pp self.group.id BREAKS, WTF?
  end
end
