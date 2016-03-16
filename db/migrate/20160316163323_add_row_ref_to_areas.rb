class AddRowRefToAreas < ActiveRecord::Migration
  def change
    add_reference :areas, :row, index: true
  end
end
