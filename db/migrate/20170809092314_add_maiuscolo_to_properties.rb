class AddMaiuscoloToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :maiuscolo, :boolean, default: false
    add_column :properties, :obbligatorio, :boolean, default: false
  end
end
