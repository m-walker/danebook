class User < ActiveRecord::Base
  before_create :generate_token
  has_secure_password

  validates :password, length: { in: 8..24 }, allow_nil: true
  validates :first_name, :last_name, :email, :dob, :gender, presence: true
  validates :email, uniqueness: true

  GENDERS = ['male', 'female', 'other']
  validates :gender, inclusion: { in: GENDERS }

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
end
