class Flirt < ActiveRecord::Base
  before_save :default_values
  belongs_to :user
  attr_accessible :name, :avatar, :provider, :handle

  # TODO
  # Need to implement destroy dependency.
  # Currently, when flirt is destroyed, the relationship remains.

  # Validations
  PROVIDERS = %w(twitter facebook)
  validates_presence_of :provider, :handle
  validates_format_of :handle, :with => /^[a-z\d_\d.]+$/
  validates :provider, :inclusion => {:in => PROVIDERS}
  validates_uniqueness_of(:handle, :scope => [ :provider, :user_id ])

  def default_values
    self.matched ||= 'false'
    self.avatar = get_avatar(self.handle)
    self.name = get_name(self.handle)
  end

  def get_name(username)
    if self.provider == 'facebook'
      name = @graph.get_object("#{username}")["name"] rescue '-- person not found'
    elsif self.provider == 'twitter'
      name = Twitter.user("#{username}").name rescue '-- person not found'
    end
  end

  def get_avatar(username)
    if self.provider == 'facebook'
      @graph = Koala::Facebook::API.new()
      avatar = @graph.get_picture("#{username}") rescue nil
    elsif self.provider == 'twitter'
      avatar = Twitter.user("#{username}").profile_image_url rescue nil
    end
  end

end
