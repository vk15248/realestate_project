class RealEstatesController < ApplicationController
  before_action :set_real_estate, only: [:show, :edit, :update, :destroy, :sold]
  before_action :logged_in_user, only: [:edit, :update, :destroy, :sold]
  before_action :correct_user, only: [:edit, :update, :destroy, :sold]

  # GET /real_estates
  # GET /real_estates.json
  def index
    @real_estates = RealEstate.where(:sold => "f")
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

    if !params[:order_by_price].nil? and params[:order_by_price] != 'none'
      @real_estates = @real_estates.order("price " + params[:order_by_price].to_s)
      flash[:success] += " Ordered by: " + params[:order_by_price]
    end
    @real_estates = @real_estates.paginate(page: params[:page], per_page: 12)
  end

  # GET /real_estates/1
  # GET /real_estates/1.json
  def show
  end

  # GET /real_estates/new
  def new
    @real_estate = RealEstate.new
    @city = default_location
  end

  # GET /real_estates/1/edit
  def edit
  end

  # POST /real_estates
  # POST /real_estates.json
  def create
    @real_estate = RealEstate.new(real_estate_params)
    @real_estate.user_id=current_user.id
    @real_estate.sold = false

    respond_to do |format|
      if @real_estate.save
        flash[:success] = "Real estate was successfully created."
        format.html {redirect_to @real_estate}
        format.json {render :show, status: :created, location: @real_estate}
      else
        format.html {render :new}
        format.json {render json: @real_estate.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /real_estates/1
  # PATCH/PUT /real_estates/1.json
  def update
    respond_to do |format|
      if @real_estate.update(real_estate_params)
        flash[:success] = "Real estate was successfully updated."
        format.html {redirect_to @real_estate}
        format.json {render :show, status: :ok, location: @real_estate}
      else
        format.html {render :edit}
        format.json {render json: @real_estate.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /real_estates/1
  # DELETE /real_estates/1.json
  def destroy
    @real_estate.destroy
    respond_to do |format|
      flash[:success] = "Real estate was successfully destroyed."
      format.html {redirect_to root_url, notice: 'Real estate was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def sold
    if @real_estate.update_attribute(:sold, true)
      flash[:success] = "Real estate was successfully updated."
      respond_to do |format|
        format.js
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_real_estate
    @real_estate = RealEstate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def real_estate_params
    params.require(:real_estate).permit(:description, :price, :lat, :lon, :picture, :price_from, :price_to, :elevator, :old_building, :renovated, :balcony, :room_number, :squared_meters, :floor)
  end

  # Confirms the correct user.
  def correct_user
    @real_estate = RealEstate.find(params[:id])
    redirect_to(root_url) unless current_user==@real_estate.user
  end

end
