class TypesController < ApplicationController
  before_action :set_type, only: :show

  def index
  end

  def show
    @bikes = @type.bikes.includes(:type, :brand).search(params[:q]).page(params[:page])
    render template: 'bikes/index'
  end

  private
    def set_type
      @type = Type.friendly.find(params[:id])
    end
end
