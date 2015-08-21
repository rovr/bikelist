class Pic < ActiveRecord::Base
  belongs_to :bike
  mount_uploader :image, ImageUploader
end
