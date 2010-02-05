class Notifications < ActionMailer::Base
  

  def message(to, group, message)
    subject    "[Publishur] Message from #{group.name}"
    recipients to
    from       'Publishur Messenger <messenger@publishur.com>'
    sent_on    Time.now
    
    body       :message => message
  end
  
  def quick_message(to, from, message)
    subject    "[Publishur] Message from #{from}"
    recipients to
    from       'Publishur Messenger <messenger@publishur.com>'
    sent_on    Time.now
    
    body       :message => message
  end
  
  def events_summary(events)
    subject     "[Publishur] Event Summary for Yesterday"
    recipients  "mwhuss@gmail.com, djbrowning@gmail.com"
    from        'Publishur Messenger <messenger@publishur.com>'
    sent_on     Time.now
    
    body        :events => events
  end

end
