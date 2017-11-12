class AddTipoToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :tipo, :string
  end
end
