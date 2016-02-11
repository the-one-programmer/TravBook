require 'digest/sha2'
require 'jwt'
require 'AuthUtil'
require 'Paperclip'
class User < ActiveRecord::Base

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  enum gender: [:female, :male ]
  validates :gender, :presence=>true
  validates :email, :presence=>true, :uniqueness=>true
  validates :name, :presence =>true
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader :password
  belongs_to :city
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :languages
  has_and_belongs_to_many :countries
  validate :password_must_be_present
  has_many :active_relationships, class_name:  "Relationship",
           foreign_key: "follower_id",
           dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
           foreign_key: "followed_id",
           dependent:   :destroy
  has_many :followeds, through: :active_relationships
  has_many :followers, through: :passive_relationships, source: :follower

  def User.find_by_credentials(email,password)
    if user = find_by_email(email)
      if user.password_digest == encrypt_password(password, user.salt)
        user
      end
    end
  end
  def User.encrypt_password(password,salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end

  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.password_digest = self.class.encrypt_password(password,salt)
    end
  end

  def gender_txt
    ["female", "male"][self.gender]
  end

  def generate_auth_token
    payload = { user_id: self.id }
    AuthToken.encode(payload)
  end

  def follow(other_user_id)
    active_relationships.create(followed_id: other_user_id)
  end

  # Unfollows a user.
  def unfollow(other_user_id)
    active_relationships.find_by(followed_id: other_user_id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user_id)
    following.include?(User.find(other_user_id))
  end

  private
  def password_must_be_present
    errors.add(:password, "Missing password") unless password_digest.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end


end
