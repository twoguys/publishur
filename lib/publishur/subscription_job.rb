class Publishur::SubscriptionJob < Struct.new(:subscription_id, :message_id)

  def perform
    subscription  = Subscription.find(subscription_id)
    message       = Message.find(message_id, :include => [:group, :user])
    
    subscription.deliver(message)
  end

end