require 'rails_helper'

describe UsersController do

  describe "GET #new" do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do

    it "with improper attributes does not create the user" do
      expect{post :create, user: attributes_for(:user, email: nil)}.not_to change(User, :count)
    end

    it "with proper attributes creates the user" do
      expect{post :create, user: attributes_for(:user_with_profile, profile_attributes: attributes_for(:profile))}.to change(User, :count).by(1)
    end

    it "sets a flash message on create" do
      post :create, user: attributes_for(:user, profile_attributes: attributes_for(:profile))
      expect(flash[:notice]).not_to be_nil
    end

    it "redirects to the user's profile" do
      post :create, user: attributes_for(:user, profile_attributes: attributes_for(:profile))
      expect(response).to redirect_to(profile_url(User.last.profile))
    end
  end

end
