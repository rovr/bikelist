class AddSlugToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :slug, :string, index:true, unique: true
    add_column :brands, :slug, :string, index:true, unique: true
    add_column :types, :slug, :string, index:true, unique: true
  end
end
