class RenameEntityLabel < ActiveRecord::Migration
  def change
    rename_column :entities, :label, :titolo
  end
end
