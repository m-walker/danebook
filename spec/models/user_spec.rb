require 'rails_helper'

describe User do

  context "validations" do
    let(:user){ build(:user) }

    it 'with a full name, email, and password is valid' do
      expect(user).to be_valid
    end

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }

    it do
      is_expected.to validate_uniqueness_of(:email).
        case_insensitive
    end

    it { is_expected.to have_secure_password }

    it do
      is_expected.to validate_length_of(:password).
        is_at_least(8).
        is_at_most(24)
    end

  end

  context 'associations' do
    it{ is_expected.to have_one(:profile).dependent(:destroy)}
    it{ is_expected.to accept_nested_attributes_for(:profile)}
    it{ is_expected.to have_many(:posts)}
    it{ is_expected.to have_many(:comments)}
    it{ is_expected.to have_many(:likes)}
    it{ is_expected.to have_many(:accepted_friendings).dependent(:destroy)}
    it{ is_expected.to have_many(:requested_friendings).dependent(:destroy)}
    it{ is_expected.to have_many(:accepted_friends)}
    it{ is_expected.to have_many(:requested_friends)}
  end

  context 'instance methods' do
    let(:user_instance){ create(:user, first_name: 'Priscilla', last_name: 'Queen') }

    it 'should return the full name with the :name method' do
      expect(user_instance.name).to eq("Priscilla Queen")
    end

    it 'should respond to :generate_token' do
      expect(user_instance).to respond_to(:generate_token)
    end

    it 'should respond to :regenerate_auth_token' do
      expect(user_instance).to respond_to(:regenerate_auth_token)
    end

    context 'friends_with?' do
      let(:user1){ create(:user) }
      let(:user2){ create(:user) }

      it 'should return true when friendship exists' do
        friend = create(:friend, requester_id: user1.id, accepter_id: user2.id)
        expect(user1.friends_with?(user2)).to be true
        expect(user2.friends_with?(user1)).to be true
      end

      it 'should return false when friendship does not exist' do
        expect(user1.friends_with?(user2)).to be false
      end
    end
  end
end