class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :user_id, :content, presence: true

  def liked_by?(user_id)
    likes.where(user_id: user_id).present?
  end
end
