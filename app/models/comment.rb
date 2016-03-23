class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true

  def liked_by?(user_id)
    likes.where(user_id: user_id).present?
  end

  def self.send_notification(resource_id, comment_id)
    comment = Comment.find(comment_id)

    if comment.commentable_type == 'Post'
      resource = Post.find(resource_id)
    elsif comment.commentable_type == 'Photo'
      resource = Photo.find(resource_id)
    else
      resource = Comment.find(resource_id)
    end

    UserMailer.comment_notification(resource, comment).deliver
  end
end
