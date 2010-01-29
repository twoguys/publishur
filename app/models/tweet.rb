class Tweet < Subscription
  
  def deliver(message)
    login         = ENV['TWITTER_LOGIN']
    password      = ENV['TWITTER_PASSWORD']
    twitter       = Publishur::Twitter.new(login, password)
    
    #twitter.direct_message(self.contact_info, "#{self.group.name}: #{self.message.body}")
    twitter.direct_message(self.contact_info, message.body)
  end

  def print_description
    "Make sure you're <a href=\"http://twitter.com/publishur\" target=\"new\">following us</a>!  You will receive <em>direct messages</em> from <strong>Publishur</strong>"
  end
  
end