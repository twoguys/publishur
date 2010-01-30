class Admin::UsersController < Admin::BaseController

  def index
    @users = User.paginate(:page => params[:page] || 1, :order => 'created_at DESC')
  end
  
end