class Notifications < ActionMailer::Base
  

  def message(receiver, group, message)
    subject    "[Publishur] Message from #{group.name}"
    recipients receiver
    from       'Publishur Messenger <messenger@publishur.com>'
    sent_on    Time.now
    
    body       :message => message
  end

end
