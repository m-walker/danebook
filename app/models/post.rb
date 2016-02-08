class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, as: :likeable, :dependent => :destroy

  validates :user_id, :content, presence: true
end
