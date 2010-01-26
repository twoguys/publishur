class Tweet < Subscription
  
  def perform
    login         = ENV['TWITTER_LOGIN']     || 'publishur'
    password      = ENV['TWITTER_PASSWORD']  || 'b33r1sc00l'
    twitter       = Publishur::Twitter.new(login, password)
    
    #twitter.direct_message(self.contact_info, "#{self.group.name}: #{self.message.body}")
    twitter.direct_message(self.contact_info, self.message.body)
  end

  def print_description
    "Make sure you're <a href=\"http://twitter.com/publishur\" target=\"new\">following us</a>!  You will receive <em>direct messages</em> from <strong>Publishur</strong>"
  end
  
end