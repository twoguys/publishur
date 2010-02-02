class JabberMessage < Subscription
  
  def deliver(message)
    im = jabber_client
    im.deliver(self.contact_info, "#{self.group.name}: #{message.body}")
  end
  
  def quick_deliver(opts={})
    im = jabber_client
    im.deliver(opts[:to], opts[:message])
  end
  
  def print_description
    "You will receive IMs from <strong>publishur.messenger</strong>"
  end
  
  private
  
  def jabber_client
    login       = ENV['JABBER_LOGIN']
    password    = ENV['JABBER_PASSWORD']
    Jabber::Simple.new(login, password)
  end
  
end