require 'rails_helper'

describe "comments/_comment.html.erb" do
  let(:user){ create(:user_with_posts) }

  context "comment made by current user" do
    before do
      @user = user
      def view.current_user
        @user
      end
    end

    it "shows delete button" do
      comment = @user.comments.first
      render "comments/comment.html.erb", comment: comment
      expect(rendered).to have_selector("a[href=\"#{comment_path(comment)}\"]", :text => "Delete")
    end
  end

  context "comment not made by current user" do
    let(:another_user){ create(:user_with_posts) }

    before do
      @user = user
      def view.current_user
        @user
      end
    end

    it "does not show delete button" do
      comment = another_user.comments.first
      render "comments/comment.html.erb", comment: comment
      expect(rendered).not_to have_selector("a[href=\"#{comment_path(comment)}\"]", :text => "Delete")
    end
  end
end