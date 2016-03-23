class AddEstesaToRows < ActiveRecord::Migration
  def change
    add_column :rows, :estesa, :boolean, default: false
  end
end
