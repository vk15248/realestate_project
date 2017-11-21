class MapController < ApplicationController
  def index
    @real_estates = RealEstate.where(:sold => 'f')
    if !(params[:price_from].nil? or params[:price_from].empty?) or !(params[:price_to].nil? or params[:price_to].empty?)
      flash[:success] = ""
    end
    if !params[:address].nil? and !params[:address].empty? and !params[:distance].nil? and !params[:distance].empty?
      @real_estates = @real_estates.near(params[:address], params[:distance], :order => false, :units => :km)
      flash[:success] = "Realestate within " + params[:distance] + " km from " + params[:address]
    end
    if !params[:price_from].nil? and !params[:price_from].empty?
      @real_estates = @real_estates.where(price_from_condition, price_from: params[:price_from])
      flash[:success] = "Price from: " + params[:price_from]
    end
    if !params[:price_to].nil? and !params[:price_to].empty?
      @real_estates = @real_estates.where(price_to_condition, price_to: params[:price_to])
      flash[:success] += " Price to: " + params[:price_to]
    end
    if !params[:floor_from].nil? and !params[:floor_from].empty?
      @real_estates = @real_estates.where(floor_from_condition, floor_from: params[:floor_from])
      flash[:success] = "Floor from: " + params[:floor_from]
    end
    if !params[:floor_to].nil? and !params[:floor_to].empty?
      @real_estates = @real_estates.where(floor_to_condition, floor_to: params[:floor_to])
      flash[:success] += " Floor to: " + params[:floor_to]
    end
    if !params[:size_from].nil? and !params[:size_from].empty?
      @real_estates = @real_estates.where(size_from_condition, size_from: params[:size_from])
      flash[:success] = "Size from: " + params[:size_from]
    end
    if !params[:size_to].nil? and !params[:size_to].empty?
      @real_estates = @real_estates.where(size_to_condition, size_to: params[:size_to])
      flash[:success] += " Size to: " + params[:size_to]
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
