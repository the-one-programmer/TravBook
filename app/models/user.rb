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
  private
  def password_must_be_present
    errors.add(:password, "Missing password") unless password_digest.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end
