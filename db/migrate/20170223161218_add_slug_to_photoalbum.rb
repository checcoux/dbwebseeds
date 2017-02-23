class AddSlugToPhotoalbum < ActiveRecord::Migration
  def change
    add_column :photoalbums, :slug, :string
    add_index :photoalbums, :slug, :unique => true
  end
end
