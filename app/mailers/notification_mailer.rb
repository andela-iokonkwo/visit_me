class NotificationMailer < ApplicationMailer
  def user_details(name, email, user_id)
    @name = name
    @user_id = user_id
    @email = email
    if @email
      mail( to: @email, subject: "Your Visitor Is Here!")
    end
  end
end
