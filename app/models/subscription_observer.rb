class SubscriptionObserver < ActiveRecord::Observer
  def after_create(subscription)
    #subscription.deliver(Message.new(:body => "Test Message"))
  end
end
