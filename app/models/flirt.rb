class Flirt < ActiveRecord::Base
  before_save :default_values
  belongs_to :user
  attr_accessible :user_id, :provider, :handle

  # Validations
  PROVIDERS = %w(twitter facebook phone email)
  validates :provider, :inclusion => {:in => PROVIDERS}
  validates_uniqueness_of(:handle, :scope => [ :provider, :user_id ])

  def default_values
    self.matched ||= 'false'
  end

end
