  module BikesLoader
    extend ActiveSupport::Concern

    included do
      def load_bike_info
        @bikes = @bikes.includes(:type, :brand, :pics).search(params[:q]).page(params[:page]).per(9)
      end
    end
  end
