class AlbumController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy, :edit]

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
  end

  def edit
  end

  private

  def picture_params
    params.require(:picture).permit(:name, :real_estate_id)
  end

end
