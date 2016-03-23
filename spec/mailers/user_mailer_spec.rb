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
end
