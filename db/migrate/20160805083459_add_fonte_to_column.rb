class AddFonteToColumn < ActiveRecord::Migration
  def change
    add_column :columns, :fonte, :integer, default: 0
  end
end
