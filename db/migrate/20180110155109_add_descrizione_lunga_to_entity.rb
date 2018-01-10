class AddDescrizioneLungaToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :descrizione_lunga, :text
  end
end
