require 'rails_helper'

describe "posts/index.html.erb" do
  let(:user){ create(:user_with_posts) }

  context "current user's posts page" do
    before do
      @user = user
      def view.current_user
        @user
      end
    end

    it "shows new post input"
  end

  context "another user's posts page" do
    let(:another_user){ create(:user_with_posts) }

    before do
      @user = another_user
      def view.current_user
        @user
      end
    end

    it "does not show new post input"
  end
end