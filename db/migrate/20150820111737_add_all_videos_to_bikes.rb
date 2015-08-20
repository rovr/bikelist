class AddAllVideosToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :all_videos, :json
  end
end
