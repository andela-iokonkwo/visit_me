class ApplicationController < ActionController::Base

  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_url, :alert => exception.message
  # end

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
