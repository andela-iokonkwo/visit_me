class PostmanWorker
  include Sidekiq::Worker

  def perform(info, count)
    info = JSON.load(info)
    NotificationMailer.user_details(info["name"], info["email"], info["user_id"]).deliver
  end

end