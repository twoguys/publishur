class JabberMessage < Subscription
  
  def perform
    login       = ENV['JABBER_LOGIN']     || 'publishur.messenger@gmail.com'
    #login       = ENV['JABBER_LOGIN']     || 'messenger@publishur.com'
    password    = ENV['JABBER_PASSWORD']  || 'b33r1sc00l'
    im          = Jabber::Simple.new(login, password)
    im.deliver(self.contact_info, "#{self.group.name}: #{self.message.body}")
  end
  
  def print_description
    "You will receive IMs from <strong>publishur.messenger</strong>"
  end
  
end