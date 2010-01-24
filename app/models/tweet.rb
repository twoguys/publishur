class Tweet < Subscription
  
  def perform
    login         = ENV['TWITTER_LOGIN']     || 'publishur'
    password      = ENV['TWITTER_PASSWORD']  || 'b33r1sc00l'
    twitter       = Twitter.new(login, password)
    
    twitter.direct_message(self.contact_info, self.message.body)
  end
  
end