class AddDefaultToRiservato < ActiveRecord::Migration
  def change
    change_column :properties, :riservato, :boolean, default: false
  end
end
