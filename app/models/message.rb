class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  validates_presence_of :body
  
  def deliver_subscriptions
    # for some reason when the observer calls this method, I can't get assocations (getting nil)
    # subs = self.group.subscriptions.for_user(self.user)
    #     subs.each do |sub|
    #       puts "delivering subscription #{sub.id}"
    #     end
  end
end
