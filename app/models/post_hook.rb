class PostHook < Subscription
  
  def perform
    Poster.post(self.contact_info, :query => { :message => self.message.body, :group => self.message.group.name, :user => self.message.user.name })
  end
  
  def print_description
    "POST information here"
  end
  
end