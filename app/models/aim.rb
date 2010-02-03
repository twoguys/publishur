class AIM < Subscription
 
  def deliver(message)
    client = aim_client
    receiver      = client.buddy_list.buddy_named(self.contact_info)
    receiver.send_im("#{self.group.name}: #{message.body}")
  end
  
  def quick_deliver(opts={})
    client        = aim_client
    receiver      = client.buddy_list.buddy_named(opts[:to])
    receiver.send_im(opts[:message])
  end
  
  def print_description
    "You will receive IMs from <strong>publishur@aim.com</strong>"
  end
  
  private
  
  def aim_client
    login         = ENV['AIM_LOGIN']
    password      = ENV['AIM_PASSWORD']
    client        = Net::TOC.new(login, password)
    client.connect
    client
  end
  
end