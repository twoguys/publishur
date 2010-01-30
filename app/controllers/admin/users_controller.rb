class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all.paginate(:page => params[:page] || 1)
  end
  
end