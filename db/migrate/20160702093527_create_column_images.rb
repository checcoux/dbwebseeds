class CreateColumnImages < ActiveRecord::Migration
  def change
    create_table :column_images do |t|
      t.text :descrizione
      t.references :column, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
