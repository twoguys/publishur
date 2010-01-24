class Twitter
  include HTTParty
  base_uri 'twitter.com'

  def initialize(user, pass)
    self.class.basic_auth user, pass
  end

  def direct_message(username, text)
    self.class.post('/statuses/update.json', :query => { :status => "d #{username} #{text}" })
  end
end