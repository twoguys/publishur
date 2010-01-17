class Transport::Base
  attr_accessor :receiver, :message, :group

   def initialize(opts={})
     @receiver = opts[:receiver]
     @message  = opts[:message]
     @group    = opts[:group]
   end

   def perform
     raise "Must implement perform method!"
   end
end