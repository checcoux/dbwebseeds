class AddRuoloToColumn < ActiveRecord::Migration
  def change
    add_column :columns, :ruolo, :string
  end
end
