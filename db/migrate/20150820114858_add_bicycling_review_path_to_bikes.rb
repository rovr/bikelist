class AddBicyclingReviewPathToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :bicycling_review_path, :string
  end
end
