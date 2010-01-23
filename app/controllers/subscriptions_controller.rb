class SubscriptionsController < ApplicationController
  before_filter :find_group
  before_filter :find_subscription, :only => [:show, :edit, :update, :destroy]
  
  def create
    if params[:subscription] && !params[:subscription][:contact_type].blank?
      @subscription = params[:subscription][:contact_type].constantize.new(params[:subscription])
      @subscription.group = @group
      @subscription.user = current_user
      @subscription.save
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    sub_params = params[@subscription.class.to_s.underscore]
    @subscription.update_attributes(sub_params)
    if @subscription.class.to_s != sub_params[:contact_type]
      @subscription.update_attribute(:type, sub_params[:contact_type])
    end
    @subscription = Subscription.find(@subscription.id)
  end
  
  def destroy
    @subscription.destroy
  end
  
  private
    def find_group
      @group = Group.find(params[:group_id])
    end
    
    def find_subscription
      @subscription = Subscription.find(params[:id])
    end
end
