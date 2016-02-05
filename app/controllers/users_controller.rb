class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.dob = Time.new(params[:year], params[:month], params[:day]).to_date

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
    params.require(:user).permit(:first_name, :last_name, :gender, :email, :password, :password_confirmation)
  end
end
