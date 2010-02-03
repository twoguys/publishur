class PostHook < Subscription
  
  def deliver(message)
    Publishur::Poster.post(self.contact_info, :query => { :message => message.body, :group => message.group.name, :user => message.user.name })
  end
  
  def quick_deliver(opts={})
    Publishur::Poster.post(opts[:to], :query => { :message => opts[:message], :group => opts[:group], :user => opts[:from] })
  end
  
  def print_description
    "POST information here"
  end
  
end