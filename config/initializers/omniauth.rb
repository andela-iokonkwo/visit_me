Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.on_failure = SessionsController.action(:destroy)
  provider :google_oauth2, ENV["google_client_id"], ENV["google_secret"],
    {
      scope:"userinfo.email, calendar",
      access_type: "offline"
    }

  provider :heroku, ENV['HEROKU_OAUTH_ID'], ENV['HEROKU_OAUTH_SECRET']

  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user,repo,gist"
end