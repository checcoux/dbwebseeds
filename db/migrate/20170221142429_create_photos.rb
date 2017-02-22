class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :photoalbum_id
      t.string :immagine

      t.timestamps null: false
    end
  end
end
