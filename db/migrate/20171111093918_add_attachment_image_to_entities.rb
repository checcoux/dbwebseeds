class AddAttachmentImageToEntities < ActiveRecord::Migration
  def self.up
    change_table :entities do |t|
      t.attachment :immagine
    end
  end

  def self.down
    remove_attachment :entities, :immagine
  end
end
