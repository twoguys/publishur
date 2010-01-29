class JabberMessage < Subscription
  
  def deliver(message)
    login       = ENV['JABBER_LOGIN']
    password    = ENV['JABBER_PASSWORD']
    im          = Jabber::Simple.new(login, password)
    im.deliver(self.contact_info, "#{self.group.name}: #{message.body}")
  end
  
  def print_description
    "You will receive IMs from <strong>publishur.messenger</strong>"
  end
  
end