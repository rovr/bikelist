class AddBikeIdToPics < ActiveRecord::Migration
  def change
    add_reference :pics, :bike, index: true, foreign_key: true
  end
end
