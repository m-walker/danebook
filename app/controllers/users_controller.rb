class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to root_url, notice: 'You successfully signed up!'
    else
      flash.now[:alert] = 'We could not sign you up. See errors below.'
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

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
