class Bike < ActiveRecord::Base
  belongs_to :brand
  belongs_to :type

  def full_url
    brand.website+url
  end
end
