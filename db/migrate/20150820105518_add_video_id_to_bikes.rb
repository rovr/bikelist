class AddVideoIdToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :video_id, :string
  end
end
