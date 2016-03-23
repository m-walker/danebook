require 'rails_helper'

describe NewsfeedController do
  let(:user){ create(:user_with_posts) }

  describe "GET #newsfeed" do
    context "signed-in user" do
      before do
        request.cookies["auth_token"] = user.auth_token
        get :newsfeed
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders the :newsfeed template" do
        expect(response).to render_template(:newsfeed)
      end

      it "assigns the user variable" do
        expect(assigns(:user)).to eq(user)
      end

      it "assigns the posts variable" do
        expect(assigns(:posts)).to eq(user.posts)
      end

      it "assigns the post variable" do
        expect(assigns(:post))
      end

      it "assigns the comment variable" do
        expect(assigns(:comment))
      end
    end

    context "not signed-in user" do
      it "redirects the user" do
        get :newsfeed
        expect(response).to have_http_status(302)
      end
    end

  end
end
