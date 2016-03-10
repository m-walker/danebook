class User < ActiveRecord::Base
  before_create :generate_token
  has_secure_password

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_many :posts
  has_many :likes
  has_many :comments
  has_many :accepted_friendings, foreign_key: :accepter_id, class_name: 'Friend'
  has_many :accepted_friends, through: :accepted_friendings, source: :requester
  has_many :requested_friendings, foreign_key: :requester_id, class_name: 'Friend'
  has_many :requested_friends, through: :requested_friendings, source: :accepter

  validates :password, length: { in: 8..24 }, allow_nil: true
  validates :first_name, :last_name, :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false

  def name
    "#{first_name} #{last_name}"
  end

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def friends_with?(user)
    requested_friends.where(id: user.id).any? || accepted_friends.where(id: user.id).any?
  end

  # Returns an array of users instead of an Active Record relation
  def all_friends
    requested_friends + accepted_friends
  end
end
