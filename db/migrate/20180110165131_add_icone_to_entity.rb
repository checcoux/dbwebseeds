class AddIconeToEntity < ActiveRecord::Migration
  def self.up
    change_table :entities do |t|
      t.attachment :icona_on
      t.attachment :icona_off
    end
  end

  def self.down
    remove_attachment :entities, :icona_on
    remove_attachment :entities, :icona_off
  end
end
