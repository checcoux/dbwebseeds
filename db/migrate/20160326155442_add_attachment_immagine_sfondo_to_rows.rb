class AddAttachmentImmagineSfondoToRows < ActiveRecord::Migration
  def self.up
    change_table :rows do |t|
      t.attachment :immagine_sfondo
    end
  end

  def self.down
    remove_attachment :rows, :immagine_sfondo
  end
end
