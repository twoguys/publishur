class Admin::DelayedJobsController < ApplicationController
  
  before_filter :require_admin
  
  def index
    @delayed_jobs = Delayed::Job.paginate :page => params[:page] || 1, :per_page => 20
  end
  
  def show
    @delayed_job = Delayed::Job.find(params[:id])
  end
  
  def destroy
    @delayed_job = Delayed::Job.find(params[:id])
    @delayed_job.destroy
    redirect_to admin_delayed_jobs_path
  end
  
  def destroy_all
    Delayed::Job.destroy_all
    redirect_to admin_delayed_jobs_path
  end
  
end