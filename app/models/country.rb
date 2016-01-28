class Country < ActiveRecord::Base
  validates :name, presence: true

  has_many :cities
  has_and_belongs_to_many :users
end
