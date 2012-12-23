class Relationship < ActiveRecord::Base
  
  # REMOVE FOR DEV
  attr_accessible :flirted_id, :flirter_id

  belongs_to :flirter, class_name: "User" 
  belongs_to :flirted, class_name: "User"

  validates :flirter_id, presence: true
  validates :flirted_id, presence: true

  # CONFIRMATION EMAIL AFTER USER SIGNUP
  #
  #
  # after_create :send_welcome_email
  def connection_email
     UserMailer.connection_email(self).deliver
  end

end
