class PostHook < Subscription
  
  def deliver(message)
    Publishur::Poster.post(self.contact_info, :query => { :message => message.body, :group => message.group.name, :user => message.user.name })
  end
  
  def print_description
    "POST information here"
  end
  
end