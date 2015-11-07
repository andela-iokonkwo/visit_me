class SessionsController < ApplicationController
  def index
  end

  def create
    set_sessions env["omniauth.auth"]
    if env['omniauth.origin'].nil?
      redirect_to root_path
    else
      redirect_to env['omniauth.origin']
    end
  end

  def create_event
    @event = {
    'summary' => 'New Event Title',
    'description' => 'The description',
    'location' => 'Location',
    'start' => { 'dateTime' => parse_time(Time.now)},
    'end' => { 'dateTime' => parse_time(Time.now + (2 * 60 * 60))},
    'attendees' => [ { "email" => 'chinedu.daniel@andela.com' },
    { "email" =>'olaide.ojewale@andela.com' } ] }

    client = Google::APIClient.new
    client.authorization.access_token = session['token']
    service = client.discovered_api('calendar', 'v3')

    @set_event = client.execute(:api_method => service.events.insert,
                            :parameters => {'calendarId' => session['email'], 'sendNotifications' => true},
                            :body => JSON.dump(@event),
                            :headers => {'Content-Type' => 'application/json'})

  end

  def parse_time(time) #:nodoc
    time.to_datetime.rfc3339
  end

  def destroy
    session.clear
    redirect_to root_url
  end

  private

    def set_sessions(omni_auth)
      if google_provider omni_auth
        set_session_values_for_google_auth
      elsif omni_auth
        user = User.first_or_create_from_omniauth env['omniauth.auth']
        session[:user_id] = user.id
      end
    end

    def google_provider(omni_auth)
      omni_auth && omni_auth['provider'] == 'google_oauth2'
    end

    def set_session_values_for_google_auth(auth)
      session['token'] = auth.credentials.token
      session['email'] = auth.info.email
      session['token_expires_at'] = auth.credentials.expires_at
    end

end
