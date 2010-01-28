class Email < Subscription
  
  def perform
    Notifications.deliver_message(self.contact_info, self.group, self.message)
  end
  
  def print_description
    "You will receive emails from <strong>messenger@publishur.com</strong>"
  end
  
end