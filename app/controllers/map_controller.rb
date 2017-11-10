class MapController < ApplicationController
  def index
    @real_estates = RealEstate.all
    if !(params[:price_from].nil? or params[:price_from].empty?) or !(params[:price_to].nil? or params[:price_to].empty?)
      flash[:success] = ""
    end
    if !params[:price_from].nil? and !params[:price_from].empty?
      @real_estates = @real_estates.where(price_from_condition, price_from: params[:price_from])
      flash[:success] = "Price from: " + params[:price_from]
    end
    if !params[:price_to].nil? and !params[:price_to].empty?
      @real_estates = @real_estates.where(price_to_condition, price_to: params[:price_to])
      flash[:success] += " Price to: " + params[:price_to]
    end
    @city = default_location

    @hash = Gmaps4rails.build_markers(@real_estates) do |realestate, marker|
      marker.lat realestate.lat
      marker.lng realestate.lon
      marker.title realestate.description
      string = realestate.description.to_s
      unless realestate.address.nil?
        string+= "<br/>" + realestate.address
      end
      string += "<br/><a href=" + real_estate_path(realestate) + " style='text-decoration: underline;'> View </a>"
      marker.infowindow string
    end
  end

  private

  def search_params
    params.permit(:price_from, :price_to)
  end
end
