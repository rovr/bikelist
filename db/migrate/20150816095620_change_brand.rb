class ChangeBrand < ActiveRecord::Migration
  def change
    add_reference :bikes, :brand, index: true, foreign_key: true
  end
end
