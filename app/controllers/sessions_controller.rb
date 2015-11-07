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

  def event(meeting)
    {
      'summary' => meeting.title,
      'description' => meeting.description,
      'location' => meeting.location,
      'start' => { 'dateTime' => parse_time(meeting.start_date)},
      'end' => { 'dateTime' => parse_time(meeting.end_time)},
      'attendees' => meeting.visitors_email.map do | email |
          { email: email }
      end
    }
  end

  def set_event(service, event)
    client.execute(:api_method => service.events.insert,
                            :parameters => {'calendarId' => session['email'], 'sendNotifications' => true},
                            :body => JSON.dump(event),
                            :headers => {'Content-Type' => 'application/json'})
  end

  def create_google_event
    meeting_info = get_schedule(user_id)
    event = event(params)
    client = Google::APIClient.new
    client.authorization.access_token = session['token']
    service = client.discovered_api('calendar', 'v3')
    @set_event = set_event(service, event)
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
        set_session_values_for_google_auth(omni_auth)
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

    # def get_schedule(user_id)
    #   Meeting.includes(:visitor, :user).where(user.id => user_id)
    # end

    def visitors_email
      visitors.pluck(:email)
    end

end