class MessageObserver < ActiveRecord::Observer
  
  def after_create(message)
    Delayed::Job.enqueue(Publishur::MessageJob.new(message.id))
    Event.create(:body => "Message sent to #{message.group.name}", :class_type => Message.to_s)
  end
  
end