class AddSectionRefToPhotoalbum < ActiveRecord::Migration
  def change
    add_reference :photoalbums, :section, index: true
  end
end
