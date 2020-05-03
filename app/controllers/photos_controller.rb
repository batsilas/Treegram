class PhotosController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    if params[:photo] == nil

      flash[:alert] = "Please upload a photo"
      redirect_to :back
    else
    @photo = Photo.create(photo_params)
      @photo.user_id = @user.id
      @photo.save
      flash[:notice] = "Successfully uploaded a photo"
      redirect_to user_path(@user)
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] ="Successfully deleted a photo."
    redirect_to :back
  end

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.create()
  
  end


  private
  def photo_params
    params.require(:photo).permit(:image, :title)
  end
end
