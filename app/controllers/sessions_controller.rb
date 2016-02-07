class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in @user
      redirect_to user_posts_path(@user), notice: "Successfully signed in!"
    else
      redirect_to root_url, alert: "There was a problem signing you in. Unknown or incorrect email or password."
    end
  end

  def destroy
    sign_out
    redirect_to root_url, notice: "Successfully logged out!"
  end
end
