class BrandsController < ApplicationController
  before_action :set_brand, :set_bikes, :load_bike_info, only: :show
  include BikesLoader

  def show
    render template: 'bikes/index'
  end

  private
    def set_brand
      @brand = Brand.friendly.find(params[:id])
    end

    def set_bikes
      @bikes = @brand.bikes
    end
end
