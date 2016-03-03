class Post < ActiveRecord::Base

  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }

  has_many :active_relationships, class_name:  "Like",
           foreign_key: "liker_id",
           dependent:   :destroy
  has_many :likers, through: :active_relationships

  def like(user_id)
    active_relationships.create(liked_id: user_id)
  end

  def unlike(user_id)
    active_relationships.find_by(liked_id: user_id).destroy
  end

  def liked?(user_id)
    liker.include?(User.find(user_id))
  end
end
