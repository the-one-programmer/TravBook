class Reply < ActiveRecord::Base
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true
  validates :reply_to, presence: true
  belongs_to :user
  belongs_to :post
end
