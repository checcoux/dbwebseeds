class AddIndiceToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :indice, :boolean, default: false

    add_index :data, :instance_id
    add_index :data, :property_id
  end
end
