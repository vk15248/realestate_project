class StaticPagesController < ApplicationController
  def home
    @latest_real_estate = RealEstate.all.order('created_at desc').paginate(page: params[:page])
  end
end
