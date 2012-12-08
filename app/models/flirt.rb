class Flirt < ActiveRecord::Base
  before_save :default_values
  belongs_to :user
  attr_accessible :user_id, :provider, :handle

  validates_presence_of :provider, :handle

  def default_values
    self.matched ||= 'false'
  end

end
