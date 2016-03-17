class AddLarghezzaToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :larghezza, :integer
  end
end
