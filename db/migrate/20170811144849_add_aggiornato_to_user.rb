class AddAggiornatoToUser < ActiveRecord::Migration
  def change
    add_column :users, :aggiornato, :boolean, default: false
  end
end
