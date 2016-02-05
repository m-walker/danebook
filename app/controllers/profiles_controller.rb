class ProfilesController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @profile = Profile.find(params[:id])
    @user = @profile.user
  end

  def profile_params

  end
end
