class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  private
  def current_user
   begin
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
   rescue ActiveRecord::RecordNotFound
     session[:user_id] = nil
   end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/unauthorised.html', alert: "Sorry, you can't access this page"
  end
  
end
