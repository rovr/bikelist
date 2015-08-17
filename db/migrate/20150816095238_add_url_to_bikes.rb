class AddUrlToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :url, :string
  end
end
