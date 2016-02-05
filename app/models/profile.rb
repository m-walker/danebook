class Profile < ActiveRecord::Base
  belongs_to :user

  validates :dob, :gender, presence: true

  GENDERS = ['male', 'female', 'other']
  validates :gender, inclusion: { in: GENDERS }
end
