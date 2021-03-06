# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  helper_method :current_user, :current_user_session
  
  before_filter :set_timezone
  
  # used to highlight current pages in the navigation
  @nav = :none
  def nav(sym)
    @nav = sym
  end
  
  # used for the page title
  @title = ''
  def title(str)
    @title = str
  end

  private
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        #store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
      return true
    end
    
    def require_admin
      unless current_user && current_user.admin?
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end
    
    def redirect_back_or(default)
      session[:return_to] ||= params[:return_to]
      if session[:return_to]
        redirect_to(session[:return_to])
      else
        redirect_to(default)
      end
      session[:return_to] = nil
    end
    
    def join_stored_groups(user)
      if session[:join_groups].is_a?(Array)
        session[:join_groups].each do |id|
          puts 'joining group: ' + id.to_s
          Group.find(id).handle_user_join(user) if Group.exists?(id)
        end
      end
      session[:join_groups] = []
    end
    
    def set_timezone
      Time.zone = current_user.timezone if current_user
    end
end
