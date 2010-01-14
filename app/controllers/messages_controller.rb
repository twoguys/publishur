class MessagesController < ApplicationController
  before_filter :find_group
  
  def create
    @message = Message.create(params[:message])
    @message.user = current_user
    if @group.messages << @message
      redirect_to @group
    else
      render @group
    end
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
