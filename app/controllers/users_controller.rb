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
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to @user.profile, notice: 'You successfully signed up! Now you can add more info to your profile.'
    else
      flash.now[:alert] = 'We could not sign you up. See errors below.'
      render :new
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
      { profile_attributes: [:gender, :dob] })
  end
end
