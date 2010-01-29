class AIM < Subscription
 
  def deliver(message)
    login         = ENV['AIM_LOGIN']
    password      = ENV['AIM_PASSWORD']
    client        = Net::TOC.new(login, password)
    client.connect
    receiver      = client.buddy_list.buddy_named(self.contact_info)
    receiver.send_im("#{self.group.name}: #{message.body}")
  end
  
  def print_description
    "You will receive IMs from <strong>publishur@aim.com</strong>"
  end
  
end