class UsersController < ApplicationController
  
  def index
    @users = User.paginate(:page => params[:page] || 1)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    if current_user
      flash[:notice] = "You're already logged in!"
      redirect_to dashboard_path 
    end
    nav :signup
    @user = User.new
    @user.account_type = "free"
  end
  def new_pro
    @user = User.new
    @user.account_type = "pro"
    render 'new'
  end
  def new_ultimate
    @user = User.new
    @user.account_type = "ultimate"
    render 'new'
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      join_stored_groups(@user)
      flash[:notice] = "Registration successful. Please sign in."
      redirect_to signin_url
    else
      render :action => 'new'
    end
  end

  def edit
    nav :settings
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated your settings."
      redirect_to dashboard_url
    else
      render :action => 'edit'
    end
  end
end
