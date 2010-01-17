class Transport::Email < Transport::Base
  
  def perform
    Notifications.deliver_message(self.receiver, self.group, self.message)
  end
  
end