class Publishur::MessageJob < Struct.new(:message_id)
  
  def perform
    message = Message.find(message_id, :include => { :group => :subscriptions })
    
    message.group.subscriptions.each do |subscription| 
      Delayed::Job.enqueue(Publishur::SubscriptionJob.new(subscription.id, message_id))
    end
  end
  
end