class Link < ActiveRecord::Base
  attr_accessible :handle, :provider
  belongs_to :user

  validates :provider, presence: true
  validates_uniqueness_of(:handle, :scope => :provider)
end
