class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper

  private
  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def default_location
    @city = Geocoder.coordinates("Sarajevo")
  end


  def search_real_estate(params, real_estates)
    @real_estates = real_estates
    if !params[:price_from].nil? and !params[:price_from].empty?
      @real_estates.where(price_from_condition, price_from: params[:price_from])
    else
      @real_estates = real_estates
    end
    if !params[:price_to].nil? and !params[:price_to].empty?
      @real_estates.where(price_to_condition, price_to: params[:price_to])
    else
      @real_estates = real_estates
    end
  end

  private

  def price_from_condition
    "price >= :price_from"
  end

  def price_to_condition
    "price <= :price_to"
  end
end
