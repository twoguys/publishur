class Notifications < ActionMailer::Base
  

  def message(receiver, group, message)
    subject    "[Publishur] Message from #{group}"
    recipients receiver
    from       'noreply@publishur.com'
    sent_on    Time.now
    
    body       :message => message
  end

end
