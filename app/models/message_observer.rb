class MessageObserver < ActiveRecord::Observer
  def after_save(message)
    message.deliver_subscriptions
  end
end