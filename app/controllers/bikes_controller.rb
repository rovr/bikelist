class BikesController < ApplicationController
  before_action :set_bike, only: :show

  def index
    @bikes = Bike.includes(:type, :brand).search(params[:q]).page(params[:page])
  end

  def show
  end

  private

  def set_bike
    @bike = Bike.friendly.find(params[:id])
  end
end
