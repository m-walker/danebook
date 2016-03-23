require 'rails_helper'

describe Comment do

  context 'associations' do
    it{ is_expected.to have_many(:likes).dependent(:destroy) }
    it{ is_expected.to belong_to(:user) }
    it{ is_expected.to belong_to(:commentable) }
  end

  context 'validations' do
    it{ is_expected.to validate_presence_of(:content) }
  end

  context 'instance methods' do
    let(:comment){ create(:comment) }

    it 'should respond to :liked_by?' do
      expect(comment).to respond_to(:liked_by?)
    end
  end

  context "class methods" do
    let(:user){ create(:user_with_posts) }
    let(:post){ user.posts.first }

    it "should send an email when :send_notification called" do
      expect{Comment.send_notification(post.id, post.comments.first.id)}.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
