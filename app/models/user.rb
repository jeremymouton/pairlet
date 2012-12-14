class User < ActiveRecord::Base

  attr_accessible :email, :password, :password_confirmation, :remember_me


  
  # INCLUDE DEFAULT DEVISE MODULES. 
  # Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  
  # OMNIAUTH AUTHENTICATION
  #
  #
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.handle = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end


  
  # RELATIONSHIPS
  #
  #
  has_many :links, dependent: :destroy, :order => 'created_at DESC'
  has_many :flirts, dependent: :destroy, :order => 'created_at DESC'

  has_many :flirted_users, through: :relationships, source: :flirted
  has_many :flirters, through: :reverse_relationships, source: :flirter
  has_many :relationships, foreign_key: "flirter_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "flirted_id",
                                   class_name: "Relationship",
                                   dependent: :destroy


                                      
  # CONFIRMATION EMAIL AFTER USER SIGNUP
  #
  #
  # after_create :send_welcome_email
  def send_welcome_email
     UserMailer.signup_confirmation(self).deliver
  end


  
  # USER RELATIONSHIPS
  #
  #
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
