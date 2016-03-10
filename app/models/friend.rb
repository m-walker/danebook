class Friend < ActiveRecord::Base
  belongs_to :requester, foreign_key: :requester_id, class_name: 'User'
  belongs_to :accepter, foreign_key: :accepter_id, class_name: 'User'

  validates_presence_of :requester, :accepter
  validates_uniqueness_of :requester_id, scope: :accepter_id

  def self.find_friendship(user1, user2)
    where("(requester_id = ? AND accepter_id = ?) OR (requester_id = ? AND accepter_id = ?)", user1.id, user2.id, user2.id, user1.id).first
  end
end
