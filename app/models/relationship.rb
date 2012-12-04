class Relationship < ActiveRecord::Base
  
  # REMOVE FOR DEV
  attr_accessible :flirted_id, :flirter_id

  belongs_to :flirter, class_name: "User" 
  belongs_to :flirted, class_name: "User"

  validates :flirter_id, presence: true
  validates :flirted_id, presence: true

end
