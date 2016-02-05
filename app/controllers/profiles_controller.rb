class ProfilesController < ApplicationController
  before_action :set_user

  def show
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

  def set_user
    @profile = Profile.find(params[:id])
    @user = @profile.user
  end

  def profile_params
    params.require(:profile).permit(:dob, :college, :about, :words_to_live_by, :hometown, :phone, :current_city)
  end
end
