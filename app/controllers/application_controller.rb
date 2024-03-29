class ApplicationController < ActionController::Base
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :restrict_access

  private
    
  # Restrict access by requiring a valid access_token
  def restrict_access
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    redirect_to :login unless @current_user
  end  
    
end
