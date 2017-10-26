class LikeController < ApplicationController
  def create
    @like = Like.new
    @like.user_id=current_user.id
    @real_estate = RealEstate.find(params[:real_estate])
    @like.real_estate = @real_estate
    @like.save
  end

  def destroy
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def like_params
    params.require(:real_estate)
  end
end
