class CreatePhotoalbums < ActiveRecord::Migration
  def change
    create_table :photoalbums do |t|
      t.string :titolo

      t.timestamps null: false
    end
  end
end
