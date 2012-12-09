class Link < ActiveRecord::Base
  attr_accessible :handle, :provider
  belongs_to :user

  # Validations
  PROVIDERS = %w(twitter facebook phone email)
  validates :provider, :inclusion => {:in => PROVIDERS}
  validates_presence_of :provider, :handle
  validates_uniqueness_of(:handle, :scope => :provider)

  def self.create_from_omniauth(auth)
    create! do |link|
      link.provider = auth["provider"]
      link.handle = auth["info"]["nickname"]
    end
  end

end
