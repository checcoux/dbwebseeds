class AddTitoloToColumnImages < ActiveRecord::Migration
  def change
    add_column :column_images, :titolo, :text
    add_column :column_images, :collegamento, :text
  end
end
