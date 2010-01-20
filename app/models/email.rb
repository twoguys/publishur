class Email < Subscription
  
  def perform
    Notifications.deliver_message(self.contact_info, self.group, self.message.body)
  end
  
end