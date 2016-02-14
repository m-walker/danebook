class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true

  def liked_by?(user_id)
    likes.where(user_id: user_id).present?
  end
end
