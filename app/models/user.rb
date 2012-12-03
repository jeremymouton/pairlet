class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :links, dependent: :destroy
  has_many :flirted_users, through: :relationships, source: :flirted
  has_many :flirters, through: :reverse_relationships, source: :flirter
  has_many :relationships, foreign_key: "flirter_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "flirted_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  
  # User relationships
  def following?(other_user)
      relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
      relationships.create!(flirted_id: other_user.id)
  end

  def unfollow!(other_user)
      relationships.find_by_followed_id(other_user.id).destroy
  end

end
