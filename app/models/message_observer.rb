class MessageObserver < ActiveRecord::Observer
  
  def after_save(message)
    Delayed::Job.enqueue(Publishur::MessageJob.new(message.id))
  end
  
end