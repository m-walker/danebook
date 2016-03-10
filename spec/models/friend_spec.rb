require 'rails_helper'

describe Friend do

  context 'associations' do
    it{ is_expected.to belong_to(:requester) }
    it{ is_expected.to belong_to(:accepter) }
  end

  context "validations" do
    subject { build(:friend) }

    it 'with an accepter and requester is valid' do
      created_users = create_pair(:user)
      friend = build(:friend, requester_id: created_users[0].id, accepter_id: created_users[1].id)
      expect(friend).to be_valid
    end

    it { is_expected.to validate_presence_of(:requester) }
    it { is_expected.to validate_presence_of(:accepter) }
    it { is_expected.to validate_uniqueness_of(:requester_id).scoped_to(:accepter_id)}
  end
end
