class Tweet < Subscription
  
  def deliver(message)
    twitter = twitter_client
    twitter.direct_message(self.contact_info, message.body)
  end
  
  def quick_deliver(opts={})
    twitter = twitter_client
    twitter.direct_message(opts[:to], opts[:message])
  end

  def print_description
    "Make sure you're <a href=\"http://twitter.com/publishur\" target=\"new\">following us</a>!  You will receive <em>direct messages</em> from <strong>Publishur</strong>"
  end
  
  private
  
  def twitter_client
    login         = ENV['TWITTER_LOGIN']
    password      = ENV['TWITTER_PASSWORD']
    Publishur::Twitter.new(login, password)
  end
  
end