class Friend < ActiveRecord::Base
  belongs_to :requester, foreign_key: :requester_id, class_name: 'User'
  belongs_to :accepter, foreign_key: :accepter_id, class_name: 'User'

  validates_presence_of :requester, :accepter
end
