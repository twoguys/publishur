class MessageObserver < ActiveRecord::Observer
  def after_save(message)
    message.group.deliver_message(message)
  end
end