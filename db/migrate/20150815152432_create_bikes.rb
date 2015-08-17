class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :name
      t.integer :year
      t.json :data

      t.timestamps
    end
  end
end
