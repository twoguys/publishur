class Admin::BaseController < ApplicationController
  before_filter :require_admin
  before_filter { |c| c.nav :admin }
  
  def index
  end
  
end