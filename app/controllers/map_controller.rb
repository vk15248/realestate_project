class MapController < ApplicationController
  def index
    @real_estates = RealEstate.where(:sold => 'f')

    if params[:distance].nil? or params[:distance].empty?
      params[:distance] = 10
    end

    if (!params[:price_from].nil? and !params[:price_from].empty?) or
        (!params[:price_to].nil? and !params[:price_to].empty?) or
        (!params[:address].nil? and !params[:address].empty? and !params[:distance].nil? and !params[:distance].empty?) or
        (!params[:floor_from].nil? and !params[:floor_from].empty?) or
        (!params[:floor_to].nil? and !params[:floor_to].empty?) or
        (!params[:size_from].nil? and !params[:size_from].empty?) or
        (!params[:size_to].nil? and !params[:size_to].empty?) or
        (!params[:rooms_from].nil? and !params[:rooms_from].empty?) or
        (!params[:rooms_to].nil? and !params[:rooms_to].empty?) or
        (!params[:balcony].nil? and !params[:balcony].empty?) or
        (!params[:elevator].nil? and !params[:elevator].empty?) or
        (!params[:renovated].nil? and !params[:renovated].empty?) or
        (!params[:old_building].nil? and !params[:old_building].empty?)
      flash[:success] = ""
    end
    if !params[:address].nil? and !params[:address].empty? and !params[:distance].nil? and !params[:distance].empty?
      @real_estates = @real_estates.near(params[:address], params[:distance], :order => false, :units => :km)
      flash[:success] += " Realestate within " + params[:distance] + " km from " + params[:address]
    end
    if !params[:price_from].nil? and !params[:price_from].empty?
      @real_estates = @real_estates.where(price_from_condition, price_from: params[:price_from])
      flash[:success] += " Price from: " + params[:price_from]
    end
    if !params[:price_to].nil? and !params[:price_to].empty?
      @real_estates = @real_estates.where(price_to_condition, price_to: params[:price_to])
      flash[:success] += " Price to: " + params[:price_to]
    end
    if !params[:floor_from].nil? and !params[:floor_from].empty?
      @real_estates = @real_estates.where(floor_from_condition, floor_from: params[:floor_from])
      flash[:success] = " Floor from: " + params[:floor_from]
    end
    if !params[:floor_to].nil? and !params[:floor_to].empty?
      @real_estates = @real_estates.where(floor_to_condition, floor_to: params[:floor_to])
      flash[:success] += " Floor to: " + params[:floor_to]
    end
    if !params[:size_from].nil? and !params[:size_from].empty?
      @real_estates = @real_estates.where(size_from_condition, size_from: params[:size_from])
      flash[:success] += " Size from: " + params[:size_from]
    end
    if !params[:size_to].nil? and !params[:size_to].empty?
      @real_estates = @real_estates.where(size_to_condition, size_to: params[:size_to])
      flash[:success] += " Size to: " + params[:size_to]
    end
    if !params[:rooms_from].nil? and !params[:rooms_from].empty?
      @real_estates = @real_estates.where(rooms_from_condition, rooms_from: params[:rooms_from])
      flash[:success] += " Rooms from: " + params[:rooms_from]
    end
    if !params[:rooms_to].nil? and !params[:rooms_to].empty?
      @real_estates = @real_estates.where(rooms_to_condition, rooms_to: params[:rooms_to])
      flash[:success] += " Rooms to: " + params[:rooms_to]
    end
    if !params[:balcony].nil? and !params[:balcony].empty?
      @real_estates = @real_estates.where("balcony = :balcony", balcony: params[:balcony])
      flash[:success] += " Balcony: " + (params[:balcony] == "t" ? "Yes" : "No")
    end
    if !params[:elevator].nil? and !params[:elevator].empty?
      @real_estates = @real_estates.where(:elevator => params[:elevator])
      flash[:success] += " Elevator: " + (params[:elevator] ? "Yes" : "No")
    end
    if !params[:renovated].nil? and !params[:renovated].empty?
      @real_estates = @real_estates.where(:renovated => params[:renovated])
      flash[:success] += " Renovated: " + (params[:renovated] ? "Yes" : "No")
    end
    if !params[:old_building].nil? and !params[:old_building].empty?
      @real_estates = @real_estates.where(:old_building => params[:old_building])
      flash[:success] += " Old Building: " + (params[:old_building] ? "Yes" : "No")
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
