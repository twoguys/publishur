class Transport::Jabber < Transport::Base
  
  def perform
    im = Jabber::Simple.new(ENV['JABBER_LOGIN'], ENV['JABBER_PASSWORD'])
    im.deliver(self.receiver, self.message)
  end
  
end