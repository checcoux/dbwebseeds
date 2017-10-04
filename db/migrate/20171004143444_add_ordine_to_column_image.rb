class AddOrdineToColumnImage < ActiveRecord::Migration
  def change
    add_column :column_images, :ordine, :integer, default: 0
  end
end
