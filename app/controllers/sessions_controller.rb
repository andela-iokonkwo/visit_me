class SessionsController < ApplicationController
  def index
  end

  def create
    if env["omniauth.auth"]
      flash[:notice] = "Provider oauth is working!"
    else
      flash[:notice] = "Provider aint working yet. Yuck!"
    end
    render :index
  end

  def destroy
    session.clear
    redirect_to root_url
  end
end
