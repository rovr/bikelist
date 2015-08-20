class Pic < ActiveRecord::Base
  belongs_to :bike, dependent: :destroy
  mount_uploader :image, ImageUploader
end
