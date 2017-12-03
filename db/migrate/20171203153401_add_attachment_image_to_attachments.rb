class AddAttachmentImageToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :immagine
    end
  end

  def self.down
    remove_attachment :attachments, :immagine
  end
end
