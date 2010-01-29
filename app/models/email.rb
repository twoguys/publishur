class Email < Subscription
  
  def deliver(message)
    Notifications.deliver_message(self.contact_info, self.group, message)
  end
  
  def print_description
    "You will receive emails from <strong>messenger@publishur.com</strong>"
  end
  
end