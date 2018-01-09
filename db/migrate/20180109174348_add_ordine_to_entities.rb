class AddOrdineToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :ordine, :integer, default: 0
  end
end
