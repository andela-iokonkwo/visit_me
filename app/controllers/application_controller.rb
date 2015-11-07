class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    id = session[:user_id]
    @user ||= User.find(id) if id
  end

  def is_loggedin?
    true if session[:user_id]
  end

end
