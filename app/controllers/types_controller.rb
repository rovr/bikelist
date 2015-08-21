class TypesController < ApplicationController
  before_action :set_type, :set_bikes, :load_bike_info, only: :show
  include BikesLoader

  def show
    render template: 'bikes/index'
  end

  private
    def set_type
      @type = Type.friendly.find(params[:id])
    end

    def set_bikes
      @bikes = @type.bikes
    end
end
