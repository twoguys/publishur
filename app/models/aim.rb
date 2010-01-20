class AIM < Subscription
 
  def perform
    login         = ENV['AIM_LOGIN'] || 'publishur'
    password      = ENV['AIM_PASSWORD'] || 'b33r1sc00l'
    client        = Net::TOC.new(login, password)
    client.connect
    receiver      = friend = client.buddy_list.buddy_named(self.contact_info)
    receiver.send_im(self.message.body)
  end
  
end