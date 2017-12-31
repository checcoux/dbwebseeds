class AddAppartenenzaIdToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :appartenenza_id, :integer, default: 0
  end
end
