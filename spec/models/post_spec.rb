require 'rails_helper'

describe Post do

  context 'validations' do
    it{ is_expected.to validate_presence_of(:content)}
    it{ is_expected.to validate_presence_of(:user_id)}
  end

  context 'associations' do
    it{ is_expected.to belong_to(:user) }
    it{ is_expected.to have_many(:likes).dependent(:destroy) }
    it{ is_expected.to have_many(:comments).dependent(:destroy) }
  end

  context 'instance methods' do
    let(:post){ create(:post) }

    it 'is expected to respond to :liked_by?' do
      expect(post).to respond_to(:liked_by?)
    end
  end
end