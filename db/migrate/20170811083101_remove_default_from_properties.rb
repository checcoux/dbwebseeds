class RemoveDefaultFromProperties < ActiveRecord::Migration
  def change
    remove_column :properties, :default
  end
end
