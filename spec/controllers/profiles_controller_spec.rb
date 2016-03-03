require 'rails_helper'

describe ProfilesController do
  let(:user){ create(:user_with_profile) }
  let(:profile){ user.profile }

  describe "GET #show" do
    before { get :show, id: profile.id }

    it "assigns the requested profile as @profile" do
      expect(assigns(:profile)).to eq(profile)
    end

    it "assigns @user as the user for @profile" do
      expect(assigns(:user)).to eq(user)
    end

    it "renders the :show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do

    context "profile is not current user's" do
      before { get :edit, id: profile.id }

      it "displays an alert message" do
        expect(flash[:alert]).not_to be_nil
      end

      it "redirects to the root url" do
        expect(response).to redirect_to(root_url)
      end
    end

    context "profile is for current user" do
      before do
        request.cookies["auth_token"] = user.auth_token
        get :edit, id: profile.id
      end

      it "assigns the requested profile as @profile" do
        expect(assigns(:profile)).to eq(profile)
      end

      it "assigns @user as the user for @profile" do
        expect(assigns(:user)).to eq(user)
      end

      it "renders the :edit template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "PUT #update" do
    let(:updated_hometown){ "New Orleans" }

    context "profile is not current user's" do
      before do
          put :update, id: profile.id, profile: attributes_for(:profile, hometown: updated_hometown)
        end

      it "does not change profile attributes" do
        profile.reload
        expect(profile.hometown).not_to eq(updated_hometown)
      end

      it "displays an alert message" do
        expect(flash[:alert]).not_to be_nil
      end

      it "redirects to the root url" do
        expect(response).to redirect_to(root_url)
      end
    end

    context "profile is for current user" do
      before do
        request.cookies["auth_token"] = user.auth_token
      end

      context "with proper attributes" do
        before do
          put :update, id: profile.id, profile: attributes_for(:profile, hometown: updated_hometown)
        end

        it "assigns the requested profile as @profile" do
          expect(assigns(:profile)).to eq(profile)
        end

        it "assigns @user as the user for @profile" do
          expect(assigns(:user)).to eq(user)
        end

        it "updates the profile" do
          profile.reload
          expect(profile.hometown).to eq(updated_hometown)
        end

        it "sets a flash message on update" do
          expect(flash[:notice]).not_to be_nil
        end

        it "redirects to the user's profile" do
          expect(response).to redirect_to(profile_url(profile))
        end
      end

      context "with invalid attributes" do
        before do
          put :update, id: profile.id, profile: attributes_for(:profile, dob: nil)
        end

        it "assigns the requested profile as @profile" do
          expect(assigns(:profile)).to eq(profile)
        end

        it "assigns @user as the user for @profile" do
          expect(assigns(:user)).to eq(user)
        end

        it "does not update the profile" do
          profile.reload
          expect(profile.dob).to eq(Date.new(1980, 1, 1))
        end

        it "re-renders the edit template" do
          expect(response).to render_template(:edit)
        end

        it "sets an alert message on fail" do
          expect(flash[:alert]).not_to be(nil)
        end
      end
    end
  end

end
