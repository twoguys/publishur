module MessagesHelper

  def message_sent_at(sent_at)
    if sent_at > Time.now
      "in #{distance_of_time_in_words(Time.now, sent_at)}"
    else
      "#{time_ago_in_words(sent_at)} ago"
    end
  end
  
end
