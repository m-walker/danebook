require "rails_helper"

describe UserMailer do
  describe "welcome" do
    let(:user){ create(:user) }
    let(:mail){ UserMailer.welcome(user) }

    it "renders the subject" do
      expect(mail.subject).to eq("Welcome to the OlympusBook!")
    end

    it "renders the sender email" do
      expect(mail.from).to eq(['siakaramalegos@gmail.com'])
    end

    it "renders the receiver email" do
      expect(mail.to).to eq(["#{user.first_name}@bar.com"])
    end

    it "renders @user.name in the body" do
      expect(mail.body.encoded).to match(user.name)
    end
  end

  describe "comment_notification" do
    let(:post_author){ create(:user_with_posts) }
    let(:comment_author){ create(:user) }
    let(:resource){ post_author.posts.first }
    let(:comment){ create(:comment, commentable_type: 'Post', commentable_id: resource.id, user: comment_author) }
    let(:mail){ UserMailer.comment_notification(resource, comment)}

    it "renders the subject" do
      expect(mail.subject).to eq("#{comment.user.name} commented on your #{comment.commentable_type}")
    end

    it "renders the sender email" do
      expect(mail.from).to eq(['siakaramalegos@gmail.com'])
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([post_author.email])
    end

    it "renders the @comment.user.name in the body" do
      expect(mail.body.encoded).to match(comment.user.name)
    end
  end
end
