class AddLimiteToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :limite, :integer, :default => 0
    add_column :entities, :caparra, :decimal, :precision => 6, :scale => 2, :default => 0
    add_column :entities, :prezzo, :decimal, :precision => 6, :scale => 2, :default => 0
  end
end
