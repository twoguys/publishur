class JabberMessage < Subscription
  
  def perform
    login       = ENV['JABBER_LOGIN']     || 'publishur.messenger@gmail.com'
    password    = ENV['JABBER_PASSWORD']  || 'b33r1sc00l'
    im          = Jabber::Simple.new(login, password)
    im.deliver(self.contact_info, self.message.body)
  end
  
end