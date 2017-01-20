class AddVisibilityToRows < ActiveRecord::Migration
  def change
    add_column :rows, :visibilita, :string, default: ''
  end
end
