class AddPluraleToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :plurale, :string
  end
end
