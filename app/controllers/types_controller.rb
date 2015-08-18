class TypesController < ApplicationController
  before_action :set_type, only: :show

  def index
  end

  def show
    @bikes = @type.bikes
    render template: 'bikes/index'
  end

  private
    def set_type
      @type = Type.find(params[:id])
    end
end
