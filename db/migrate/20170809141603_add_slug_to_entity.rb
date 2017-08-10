class AddSlugToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :slug, :string
    add_index :entities, :slug, unique: true
  end
end
