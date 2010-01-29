class Admin::UsersController < ApplicationController
  before_filter :require_admin
  before_filter { |c| c.nav :admin }
  
  def index
    @users = User.all.paginate(:page => params[:page] || 1)
  end
  
end