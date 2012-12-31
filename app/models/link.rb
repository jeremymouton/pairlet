class Link < ActiveRecord::Base
  attr_accessible :handle, :provider, :uid
  belongs_to :user

  # Validations
  PROVIDERS = %w(twitter facebook)
  validates :provider, :inclusion => {:in => PROVIDERS}
  validates_presence_of :provider, :handle
  validates_uniqueness_of(:handle, :scope => :provider)

  def self.create_from_omniauth(auth)
    create! do |link|
      link.provider = auth.provider
      link.handle = auth.info.nickname.gsub(/[.]/, '').to_s
      link.uid = auth.uid
      link.name = auth.info.name
      link.oauth_token = auth.credentials.token rescue nil
      link.oauth_expires_at = Time.at(auth.credentials.expires_at) rescue nil
    end
  end

end
