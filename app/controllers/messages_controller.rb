class MessagesController < ApplicationController
  before_filter :find_group
  
  def create
    @message      = Message.new(params[:message])
    @message.user = current_user
    @message.send_at = Time.now unless params[:group_send_in_the_future]
    
    @group.messages << @message if @message.valid?
    redirect_to @group
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to @group
  end
  
  private
    def find_group
      @group = Group.find(params[:group_id])
    end
end
