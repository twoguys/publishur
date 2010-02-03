class Publishur::QuickMessageJob < Struct.new(:opts)
  
  def perform
    # subject = opts[:subject]
    # message = opts[:message]
    # to      = opts[:to]
    # from    = opts[:from]
    # type    = opts[:type]
    
    subscription = opts[:type].constantize.new
    subscription.quick_deliver(opts)
  end
  
end