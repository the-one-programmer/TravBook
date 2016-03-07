class Post < ActiveRecord::Base
  self.per_page = 10
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }

  has_many :active_relationships, class_name:  "Like",
           foreign_key: "liked_id",
           dependent:   :destroy
  has_many :likers, through: :active_relationships
  has_many :replies, dependent: :destroy

  def like(user_id)
    active_relationships.create(liker_id: user_id)
  end

  def unlike(user_id)
    active_relationships.find_by(liker_id: user_id).destroy
  end

  def liked?(user_id)
    liker.include?(User.find(user_id))
  end

  def type
    if (original_post_id == nil)
      "normal"
    else
      "repost"
    end
  end

  def number_of_reposts
    Post.where(:original_post_id => id).count
  end
end
