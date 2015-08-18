class BrandsController < ApplicationController
  before_action :set_brand, only: :show

  def index
  end

  def show
    @bikes = @brand.bikes
    render template: 'bikes/index'
  end

  private
    def set_brand
      @brand = Brand.find(params[:id])
    end
end
