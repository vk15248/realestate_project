class AlbumController < ApplicationController
  before_action :correct_user, only: [:new, :create, :destroy, :edit]

  def new
    @picture = Picture.new
    @real_estate = RealEstate.find(params[:real_estate_id])
    @picture.real_estate = @real_estate
  end

  def create
    @real_estate = RealEstate.find(params[:real_estate_id])
    @picture = @real_estate.pictures.build(picture_params)
    if @picture.valid? && @real_estate.valid?
      @picture.save
    end
    redirect_to new_real_estate_album_url
  end

  def destroy
    @real_estate = RealEstate.find(params[:real_estate_id])
    @picture = Picture.find(params[:id])
    @real_estate.pictures.delete(@picture)
    @picture.delete
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  private

  def picture_params
    params.require(:picture).permit(:name, :real_estate_id, :id)
  end

  # Confirms the correct user.
  def correct_user
    @real_estate = RealEstate.find(params[:real_estate_id])
    redirect_to(root_url) unless current_user==@real_estate.user
  end
end
