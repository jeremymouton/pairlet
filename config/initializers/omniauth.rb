# OmniAuth for user account authentication
# http://railscasts.com/episodes/241-simple-omniauth-revised

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, KEYS['twitter_key'], KEYS['twitter_secret']
  provider :facebook, KEYS['facebook_key'], KEYS['facebook_secret']
end