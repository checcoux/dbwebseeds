class AddCopertinaToPhotoalbums < ActiveRecord::Migration
  def change
    add_column :photoalbums, :copertina, :integer, default: 0
  end
end
