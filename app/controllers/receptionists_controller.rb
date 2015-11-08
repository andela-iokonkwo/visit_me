class ReceptionistsController < ApplicationController
  def index
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
    mail_worker
    check_time("checkin")
  end

  def delete
  end

  private

  def mail_worker(name = "olaide", email = "ojewaleolaide@gmail.com", user_id= 1)
    info = JSON.generate({
        name: name,
        email: email,
        user_id: user_id
    })
    PostmanWorker.new.perform(info,2)
  end

  def check_time(value_to_update)
    Meeting.where(user_id: session[:user_id]).update_column(value_to_update => Time.now)
  end

end
