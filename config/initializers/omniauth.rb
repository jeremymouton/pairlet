# OmniAuth for user account authentication
# http://railscasts.com/episodes/241-simple-omniauth-revised

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, TWITTER_KEY, TWITTER_SECRET
end