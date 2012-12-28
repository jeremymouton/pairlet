class Flirt < ActiveRecord::Base
  before_save :default_values
  belongs_to :user
  attr_accessible :user_id, :provider, :handle

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
  end

end
