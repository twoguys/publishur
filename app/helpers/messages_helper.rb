module MessagesHelper

  def message_sent_at(message)
    if message.send_at && message.send_at > Time.now
      "in #{distance_of_time_in_words(Time.now, message.send_at)}"
    else
      "#{time_ago_in_words(message.created_at)} ago"
    end
  end
  
end
