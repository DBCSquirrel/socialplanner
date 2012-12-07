class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_login!
    redirect_to new_user_path unless signed_in?
  end

  def signed_in?
    current_user.present?
  end

  before_filter :require_login!

  private
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
