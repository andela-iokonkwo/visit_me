class SessionsController < ApplicationController
  def index
  end

  def create
    omni_auth = env["omniauth.auth"]
    if google_provider omni_auth
        set_session_values_for_google_auth(omni_auth)
        redirect_to google_event_path
      elsif omni_auth
        user = User.first_or_create_from_omniauth env['omniauth.auth']
        session[:user_id] = user.id
        redirect_to meetings_path
      end
  end

  def destroy
    session.clear
    redirect_to root_url
  end

  private

    def google_provider(omni_auth)
      omni_auth && omni_auth['provider'] == 'google_oauth2'
    end

    def set_session_values_for_google_auth(auth)
      session['token'] = auth.credentials.token
      session['email'] = auth.info.email
      session['token_expires_at'] = auth.credentials.expires_at
    end

end