class Admin::EventsController < Admin::BaseController
  
  def index
    @events = Event.paginate(:page => params[:page] || 1)
  end
  
end