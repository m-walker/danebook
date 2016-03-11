class PhotosController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @photo = @user.photos.build(photo_params)

    if @photo.save
      redirect_to user_photos_path(@user), notice: 'Photo successfully added'
    else
      flash.now[:alert] = 'There was a problem adding the photo.'
      render :new
    end
  end

  def index
    @user = User.find(params[:user_id])
    @photo = Photo.new
    @photos = @user.photos
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:photo)
  end
end
