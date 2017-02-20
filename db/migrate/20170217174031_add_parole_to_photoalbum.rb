class AddParoleToPhotoalbum < ActiveRecord::Migration
  def change
    add_column :photoalbums, :parole, :text
  end
end
