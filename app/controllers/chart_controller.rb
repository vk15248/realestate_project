class ChartController < ApplicationController
  before_action :logged_in_user, only: [:index, :create]

  def index
  end

  def create
    @id = SecureRandom.hex(10)
    @data = Hash.new
    @title = ""
    @group_by = :created_at

    if !params[:group].nil? and !params[:group].empty?
      if params[:data]["re"]
        @title = "Realestate added"
        if params[:group] == "building"
          @title = @title + " - Building Type"
          @data["old"] = RealEstate.where(:old_building => 't')
          @data["new"] = RealEstate.where(:old_building => 'f')
        elsif params[:group] == "balcony"
          @title = @title + " - Balcony"
          @data["yes"] = RealEstate.where(:balcony => 't')
          @data["no"] = RealEstate.where(:balcony => 'f')
        elsif params[:group] == "sold"
          @title = @title + " - Sold"
          @data["yes"] = RealEstate.where(:sold => 't')
          @data["no"] = RealEstate.where(:sold => 'f')
        elsif params[:group] == "renovated"
          @title = @title + " - Renovated"
          @data["yes"] = RealEstate.where(:renovated => 't')
          @data["no"] = RealEstate.where(:renovated => 'f')
        elsif params[:group] == "room"
          @title = @title + " - Room"
          for i in 0..RealEstate.maximum(:room_number)
            @data[i] = RealEstate.where(:room_number => i)
          end
        end
      else
        @title = "Likes added"
        @group_by = "likes.created_at"
        if params[:group] == "building"
          @title = @title + " - Building Type"
          @data["old"] = Like.joins(:real_estate).where(real_estates: {old_building: 't'})
          @data["new"] = Like.joins(:real_estate).where(real_estates: {old_building: 'f'})
        elsif params[:group] == "balcony"
          @title = @title + " - Balcony"
          @data["yes"] = Like.joins(:real_estate).where(real_estates: {balcony: 't'})
          @data["no"] = Like.joins(:real_estate).where(real_estates: {balcony: 'f'})
        elsif params[:group] == "sold"
          @title = @title + " - Sold"
          @data["yes"] = Like.joins(:real_estate).where(real_estates: {sold: 't'})
          @data["no"] = Like.joins(:real_estate).where(real_estates: {sold: 'f'})
        elsif params[:group] == "renovated"
          @title = @title + " - Renovated"
          @data["yes"] = Like.joins(:real_estate).where(real_estates: {renovated: 't'})
          @data["no"] = Like.joins(:real_estate).where(real_estates: {renovated: 'f'})
        elsif params[:group] == "room"
          @title = @title + " - Room"
          for i in 0..RealEstate.maximum(:room_number)
            @data[i] = Like.joins(:real_estate).where(real_estates: {room_number: i})
          end
        end
      end
    else
      if params[:data]["re"]
        @title = "Realestate added"
        @data["All"] = RealEstate.all
      else
        @title = "Likes added"
        @data["All"] = Like.all
      end
    end

    @chart_type = if params[:type].nil? or params[:type].empty?
                    "line"
                  else
                    params[:type]
                  end

    @data.each do |key, value|
      if @chart_type!="pie"
        if !params[:range].nil? and !params[:range].empty? and params[:range]!="all"
          if params[:range] == "month"
            @data[key] = value.group_by_month(@group_by)
          elsif params[:range] == "week"
            @data[key] = value.group_by_week(@group_by)
          end
        else
          @data[key] = value.group_by_day(@group_by)
        end
      end
      if params[:data]=="re_p"
        @data[key] = @data[key].average(:price)
      else
        @data[key] = @data[key].count
      end
    end

    respond_to do |format|
      format.js
    end
  end
end