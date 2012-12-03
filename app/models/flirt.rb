class Flirt < ActiveRecord::Base
  belongs_to :user
  attr_accessible :handle
end
