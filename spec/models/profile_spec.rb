require 'rails_helper'

describe Profile do

  context 'validations' do

    it{ is_expected.to validate_presence_of(:dob)}
    it{ is_expected.to validate_presence_of(:gender)}

    it do
      is_expected.to validate_inclusion_of(:gender).
        in_array(['male', 'female', 'other'])
    end
  end

  context 'associations' do
    it{ is_expected.to belong_to(:user)}
  end

end