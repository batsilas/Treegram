class User<ActiveRecord::Base
  has_many :photos
  has_many :tags
 
  has_many :comments
  has_many :active_follows, {class_name: "Follow", foreign_key: "follower_id",dependent: :destroy}
  has_many :following, through: :active_follows, source: :followed  
  

  attr_accessor :password
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_confirmation_of :password
  before_save :encrypt_password
  validates :email, uniqueness: true

  validates :email, :presence => true
  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def is_email?
    self.email.include?('@') && self.email.include?('.')
  end

  def self.authenticate(email, password)
    user = User.where(email: email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end
    
  def following?(other_user)
    following.include?(other_user)
  end

end
