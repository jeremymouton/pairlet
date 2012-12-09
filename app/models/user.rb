class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body



  # Relationships
  has_many :links, dependent: :destroy, :order => 'created_at DESC'
  has_many :flirts, dependent: :destroy, :order => 'created_at DESC'

  has_many :flirted_users, through: :relationships, source: :flirted
  has_many :flirters, through: :reverse_relationships, source: :flirter
  has_many :relationships, foreign_key: "flirter_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "flirted_id",
                                   class_name: "Relationship",
                                   dependent: :destroy




  # Confirmation email after user signup
  after_create :send_welcome_email
  def send_welcome_email
     UserMailer.signup_confirmation(self).deliver
  end



  
  # User relationships
  def following?(other_user)
    relationships.find_by_flirted_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(flirted_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_flirted_id(other_user.id).destroy
  end

  def following_me?(other_user)
    other_user.relationships.where(:flirted_id => self.id).any?
  end

  def mutual_flirts?(other_user)
    following?(other_user) && following_me?(other_user)
  end

end
