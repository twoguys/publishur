class Admin::DelayedJobsController < ApplicationController
  
  def index
    @delayed_jobs = Delayed::Job.paginate :page => params[:page] || 1, :per_page => 20
  end
  
  def show
    @delayed_job = Delayed::Job.find(params[:id])
  end
  
end