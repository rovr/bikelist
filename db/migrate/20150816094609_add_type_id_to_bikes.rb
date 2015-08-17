class AddTypeIdToBikes < ActiveRecord::Migration
  def change
    add_reference :bikes, :type, index: true, foreign_key: true
  end
end
