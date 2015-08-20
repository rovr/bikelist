class BrandsController < ApplicationController
  before_action :set_brand, only: :show

  def index
  end

  def show
    @bikes = @brand.bikes.includes(:type, :brand).search(params[:q]).page(params[:page])
    render template: 'bikes/index'
  end

  private
    def set_brand
      @brand = Brand.friendly.find(params[:id])
    end
end
