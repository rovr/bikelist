module BikesHelper

  def image_col_size i
    i==0 ? 'col-md-12' : 'col-md-3'
  end

  def first_image_url bike
    bike.pics.first.try(:image).try(:grid).try(:url) || '/no-image.png'
  end

  def show_title
    "#{@bike.brand.name} #{@bike.name} :: Best Price & Reviews"
  end

  def index_title
    "#{params[:q]} #{@brand.try(:name) || @type.try(:name) || ''} Bikes :: Best Price & Reviews"
  end
end
