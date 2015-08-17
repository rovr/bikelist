class Bike < ActiveRecord::Base
  belongs_to :brand
  belongs_to :type

  scope :search, -> (q) {where("name @@ :q", q: q) if q}


  def full_url
    brand.website+url
  end
end
