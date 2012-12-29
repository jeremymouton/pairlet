class Link < ActiveRecord::Base
  attr_accessible :handle, :provider
  belongs_to :user

  # Validations
  PROVIDERS = %w(twitter facebook)
  validates :provider, :inclusion => {:in => PROVIDERS}
  validates_presence_of :provider, :handle
  validates_uniqueness_of(:handle, :scope => :provider)

  def self.create_from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |link|
      link.provider = auth.provider
      link.handle = auth.info.nickname || auth.uid
      link.uid = auth.uid
      link.oauth_token = auth.credentials.token rescue nil
      link.oauth_expires_at = Time.at(auth.credentials.expires_at) rescue nil
      link.save!
    end
  end

  # get fb oauth creds in fb account is authorized
  # user.links(:where => {:provider => 'facebook'}).first.facebook.get_connection("me", "friends")

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil # or consider a custom null object
  end

end
