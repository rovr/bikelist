class Bike < ActiveRecord::Base
  belongs_to :brand
  belongs_to :type
  has_many :pics

  include FriendlyId
  friendly_id :brand_and_name, use: :slugged

  scope :search, -> (q) {where("name @@ :q", q: q) if q}

  def full_url
    brand.website+url
  end

  def brand_and_name
    "#{brand.name}-#{name}"
  end

  def full_name
    "#{name} #{brand.name} #{year}"
  end

  def bicycling_review_path
    super && "http://gearfinder.bicycling.com"+super
  end

  def video_id
    super || all_videos.first[1]
  end
end
