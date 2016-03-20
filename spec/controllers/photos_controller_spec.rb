require 'rails_helper'

describe PhotosController do
  let(:user){ create(:user_with_profile) }
  let(:photo){ create(:photo, user_id: user.id) }

  describe "GET #show" do

    context "signed-in user" do
      before do
        request.cookies["auth_token"] = user.auth_token
        get :show, {id: photo.id, user_id: user.id}
      end

      it "renders the :show template" do
        expect(response).to render_template(:show)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "assigns the user variable" do
        expect(assigns(:user)).to eq(user)
      end

      it "assigns the photo variable" do
        expect(assigns(:photo)).to eq(photo)
      end

      it "assigns the comment variable" do
        expect(assigns(:comment))
      end
    end

    context "not signed-in user" do
      it "redirects the user" do
        get :show, {id: photo.id, user_id: user.id}
        expect(response).to have_http_status(302)
      end
    end

    context "current user not friend of user with photo" do
      it "redirects the user" do
        other_user = create(:user)
        request.cookies["auth_token"] = other_user.auth_token
        get :show, {id: photo.id, user_id: user.id}
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "GET #index" do

    context "signed-in user" do
      before do
        request.cookies["auth_token"] = user.auth_token
        get :index, user_id: user.id
      end

      it "renders the :index template" do
        expect(response).to render_template(:index)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "assigns the user variable" do
        expect(assigns(:user)).to eq(user)
      end

      it "assigns the photos variable" do
        expect(assigns(:photos))
      end

      it "assigns the photo variable" do
        expect(assigns(:photo))
      end
    end

    context "not signed-in user" do
      it "redirects the user" do
        get :index, user_id: user.id
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "POST #create" do

    context "signed-in user" do
      before do
        request.cookies["auth_token"] = user.auth_token
        post :create, photo: photo.attributes
      end

      it "assigns the photo variable" do
        expect(assigns(:photo))
      end

      it "uploads a photo" do
        photo.reload
        expect(photo.photo).not_to be_nil
      end

      it "redirects to the photos index" do
        expect(response).to redirect_to(user_photos_url(user))
      end
    end

    context "not signed-in user" do
      it "redirects the user" do
        post :create
        expect(response).to have_http_status(302)
      end
    end
  end
end
