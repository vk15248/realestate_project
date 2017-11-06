class RealEstatesController < ApplicationController
  before_action :set_real_estate, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /real_estates
  # GET /real_estates.json
  def index
    if params[:price_from].nil? and params[:price_to].nil?
      @real_estates = RealEstate.all.paginate(page: params[:page], per_page: 12)
    else
      @real_estates = RealEstate.where(search(params), price_from: params[:price_from], price_to: params[:price_to]);
      if params[:order_by_price] != 'none'
        @real_estates = @real_estates.order("price " + params[:order_by_price].to_s)
      end
      @real_estates = @real_estates.paginate(page: params[:page], per_page: 12)
    end
  end

  # GET /real_estates/1
  # GET /real_estates/1.json
  def show
  end

  # GET /real_estates/new
  def new
    @real_estate = RealEstate.new
  end

  # GET /real_estates/1/edit
  def edit
  end

  # POST /real_estates
  # POST /real_estates.json
  def create
    @real_estate = RealEstate.new(real_estate_params)
    @real_estate.user_id=current_user.id

    respond_to do |format|
      if @real_estate.save
        flash[:success] = "Real estate was successfully created."
        format.html {redirect_to @real_estate, notice: 'Real estate was successfully created.'}
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
        format.html {redirect_to @real_estate, notice: 'Real estate was successfully updated.'}
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_real_estate
    @real_estate = RealEstate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def real_estate_params
    params.require(:real_estate).permit(:description, :price, :lat, :lon, :picture, :price_from, :price_to)
  end

  # Confirms the correct user.
  def correct_user
    @real_estate = RealEstate.find(params[:id])
    redirect_to(root_url) unless current_user==@real_estate.user
  end

  def search(params)
    conditions = ""
    if !params[:price_from].empty?
      conditions = "price >= :price_from"
    end
    if !params[:price_to].empty?
      if !conditions.nil? and !conditions.empty?
        conditions+=" and "
      end
      conditions += "price <= :price_to"
    end
  end
end
