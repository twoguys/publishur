class Email < Subscription
  
  def deliver(message)
    Notifications.deliver_message(self.contact_info, self.group, message)
  end
  
  def quick_deliver(opts)
    Notifications.deliver_quick_message(opts[:to], opts[:group], opts[:message])
  end
  
  def print_description
    "You will receive emails from <strong>messenger@publishur.com</strong>"
  end
  
end