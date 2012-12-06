class Flirt < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :handle

  validates_presence_of :provider, :handle
end
