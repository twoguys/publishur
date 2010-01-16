class MessageObserver < ActiveRecord::Observer
  def after_save(message)
    group = message.group
    group.deliver_message(message)
    #message.deliver_subscriptions
  end
end