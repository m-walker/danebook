class ProfilesController < ApplicationController
  before_action :require_login, except: [:show]
  before_action :set_current_user_profile, except: [:show]

  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profile successfully updated!"
    else
      flash.now[:alert] = "There was a problem saving your profile."
      render :edit
    end
  end

  private

  def set_current_user_profile
    unless params[:id] == current_user.profile.id.to_s
      redirect_to root_url, alert: "You are not authorized to access."
      return
    end
    @user = current_user
    @profile = @user.profile
  end

  def profile_params
    params.require(:profile).permit(:dob, :college, :about, :words_to_live_by, :hometown, :phone, :current_city)
  end
end
