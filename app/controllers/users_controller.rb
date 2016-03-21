class UsersController < ApplicationController

  def index
    if params[:search]
      search_string = params[:search].downcase
      @users = User.where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?", "%#{search_string}%", "%#{search_string}%")
    else
      @users = User.all
    end
  end

  def new
    if signed_in_user?
      redirect_to user_posts_url(current_user)
      return
    end
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)

    if @user.save
      User.send_welcome_email(@user.id)

      sign_in(@user)
      redirect_to @user.profile, notice: 'You successfully signed up! Now you can add more info to your profile.'
    else
      flash.now[:alert] = 'We could not sign you up. See errors below.'
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    require_current_user

    # TODO: this does not look kosher
    if params[:user][:profile_photo_id]
      if @user.photos.where(id: params[:user][:profile_photo_id]).empty?
        redirect_to user_photos_url(@user), alert: "Invalid photo selection."
      end
    end

    if params[:user][:cover_photo_id]
      if @user.photos.where(id: params[:user][:cover_photo_id]).empty?
        redirect_to user_photos_url(@user), alert: "Invalid photo selection."
      end
    end

    if @user.update(user_params)
      redirect_to user_posts_url(@user), notice: "User successfully updated."
    else
      redirect_to user_posts_url(@user), alert: "Could not make requested change."
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :cover_photo_id,
      :profile_photo_id,
      { profile_attributes: [:gender, :dob] })
  end
end
