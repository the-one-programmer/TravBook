class User < ActiveRecord::Base
  enum gender: [ :prefer_not_to_disclose, :female, :male ]

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :gender, presence: true, inclusion: { in: gender.keys }
  validates :age, inclusion: { in: 1..128 }
  validates_format_of :nationality, with: /\w*/i

  belongs_to :city
  has_and_belongs_to_many :interests
  has_secure_password
end
