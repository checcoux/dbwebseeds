class AddAttachmentImmagineToColumnImages < ActiveRecord::Migration
  def self.up
    change_table :column_images do |t|
      t.attachment :immagine
    end
  end

  def self.down
    remove_attachment :column_images, :immagine
  end
end
