class AddPercorsoToSection < ActiveRecord::Migration
  def change
    add_column :sections, :percorso, :string
  end
end
