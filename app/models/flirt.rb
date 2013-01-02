class Flirt < ActiveRecord::Base
  before_save :default_values
  belongs_to :user
  attr_accessible :name, :avatar, :provider, :handle

  # TODO
  # Need to implement destroy dependency.
  # Currently, when flirt is destroyed, the relationship remains.

  # Validations
  PROVIDERS = %w(twitter facebook)
  validates_presence_of :provider, :handle, :message => "The usernme can't be blank"
  validates_format_of :handle, :with => /^[a-zA-Z\d_\d.]+$/, :message => "This username is not valid."
  validates_uniqueness_of(:handle, :scope => [ :provider, :user_id ], :message => "You've already added this person!")
  validates :provider, :inclusion => { :in => PROVIDERS, :message => "Could not save this person" }
  validate :flirt_count_within_limit, :on => :create

  def default_values
    self.handle = fix_username(self.handle)
    self.matched ||= 'false'
    self.avatar = get_avatar(self.handle)
    self.name = get_name(self.handle)
  end

  def flirt_count_within_limit # check if user is subscriber or not.
    if self.user.flirts(:reload).count >= 1 && !user.subscribed?
      errors.add(:base, "- Exceeded limit. Upgrade your account to add more people.")
    end
  end

  def get_name(username)
    if self.provider == 'facebook'
      name = @graph.get_object("#{username}")["name"] rescue 'person not found'
    elsif self.provider == 'twitter'
      name = Twitter.user("#{username}").name rescue 'person not found'
    end
  end

  def get_avatar(username)
    if self.provider == 'facebook'
      @graph = Koala::Facebook::API.new()
      avatar = @graph.get_picture("#{username}") rescue ''
    elsif self.provider == 'twitter'
      avatar = Twitter.user("#{username}").profile_image_url rescue ''
    end
  end

  def fix_username(string)
    string.downcase.gsub(/[.]/, '').to_s
  end

end
