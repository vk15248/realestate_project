class MapController < ApplicationController
  def index
    @real_estate = RealEstate.all

    @hash = Gmaps4rails.build_markers(@real_estate) do |realestate, marker|
      marker.lat realestate.lat
      marker.lng realestate.lon
      marker.title realestate.description
      string = realestate.description.to_s
     # string = "<a href=" + real_estate_path(realestate) + " style='text-decoration: underline;'>" + realestate.description.to_s + "</a>"
      unless realestate.address.nil?
        string+= "<br/>" + realestate.address
      end
      string += "<br/><a href=" + real_estate_path(realestate) + " style='text-decoration: underline;'> View </a>"
      marker.infowindow string
    end
  end
end
