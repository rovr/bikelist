class Brand < ActiveRecord::Base
  has_many :bikes
  include FriendlyId
  friendly_id :name, use: :slugged
end
