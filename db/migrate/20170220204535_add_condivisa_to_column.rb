class AddCondivisaToColumn < ActiveRecord::Migration
  def change
    add_column :columns, :condivisa, :boolean, default: true
  end
end
