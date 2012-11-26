class Link < ActiveRecord::Base
  attr_accessible :handle, :provider
  belongs_to :user

  validates :provider, presence: true
  validates :handle, presence: true, uniqueness: true
end
