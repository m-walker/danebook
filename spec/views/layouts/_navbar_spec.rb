require 'rails_helper'

describe "layouts/_navbar.html.erb" do
  let(:user){ create(:user) }

  context "logged in user" do
    before do
      def view.signed_in_user?
        true
      end

      @user = user
      def view.current_user
        @user
      end
    end

    it "shows logout link" do
      render
      expect(rendered).to have_selector("a[href=\"#{logout_path}\"]", :text => "Log Out")
    end
  end

  context "not logged in user" do
    before do
      def view.signed_in_user?
        false
      end
    end

    it "shows sign in form" do
      render
      expect(rendered).to have_selector("form[action=\"#{login_path}\"]")
    end
  end
end