class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  
  validates_presence_of :body
  
  def mine?(user)
    user && self.user == user
  end
  
  def young?
    Time.now - self.created_at < 10.minutes
  end
  
  # def deliver_subscriptions
  #   # for some reason when the observer calls this method, I can't get assocations (getting nil)
  #   self.reload
  #   subs = self.group.subscriptions.for_user(self.user)
  #   subs.each do |sub|
  #     logger.info "[Publishur] Delivering subscription #{sub.id}"
  #     Delayed::Job.enqueue sub.deliver(self.body)
  #   end
  # end
end
