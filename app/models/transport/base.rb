class Transport::Base
  attr_accessor :receiver, :message

   def initialize(opts={})
     @receiver = opts[:receiver]
     @message  = opts[:message]
   end

   def perform
     raise "Must implement perform method!"
   end
end