require 'chronic'
class SessionsController < ApplicationController
  def index
  end

  def create
    if env["omniauth.auth"]

        session[:token] = env["omniauth.auth"]["credentials"]["token"]
        session[:email] = env["omniauth.auth"]["info"]["email"]
        create_event
      flash[:notice] = "Provider oauth is working!"
    else
      flash[:notice] = "Provider aint working yet. Yuck!"
    end
    render :index
  end

  def create_event
    @event = {
      'summary' => 'New Event Title',
      'description' => 'The description',
      'location' => 'Location',
      'start' => { 'dateTime' => Chronic.parse('tomorrow 4 pm') },
      'end' => { 'dateTime' => Chronic.parse('tomorrow 5pm') },
      'attendees' => [ { "email" => 'olaide.ojewale@gmail.com' },
      { "email" =>'chinedu.daniel@gmail.com' }, { "email" =>'osmond.oranagwa@gmail.com' } ] }

      client = Google::APIClient.new
      client.authorization.access_token = session[:token]
      service = client.discovered_api('calendar', 'v3')

      @set_event = client.execute(:api_method => service.events.insert,
                              :parameters => {'calendarId' => session[:email], 'sendNotifications' => true},
                              :body => JSON.dump(@event),
                              :headers => {'Content-Type' => 'application/json'})
      require "pry"; binding.pry
  end

  def destroy
    session.clear
    redirect_to root_url
  end
end
