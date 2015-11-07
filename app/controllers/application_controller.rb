class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :is_loggedin?

  def current_user
    id = session[:user_id]
    @user ||= User.find(id) if id
  end

  def is_loggedin?
    redirect_to root_url unless session[:user_id]
  end

end
