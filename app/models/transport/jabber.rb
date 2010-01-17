class Transport::Jabber < Transport::Base
  
  def perform
    login       = ENV['JABBER_LOGIN']     || 'publishur.messenger@gmail.com'
    password    = ENV['JABBER_PASSWORD']  || 'b33r1sc00l'
    im          = Jabber::Simple.new(login, password)
    im.deliver(self.receiver, self.message)
  end
  
end