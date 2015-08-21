class BikesController < ApplicationController
  before_action :set_bike, only: :show
  before_action :set_bikes, :load_bike_info, only: :index
  include BikesLoader

  def index
  end

  def show
  end

  private

  def set_bike
    @bike = Bike.friendly.find(params[:id])
  end

  def set_bikes
    @bikes = Bike.random
  end
end
