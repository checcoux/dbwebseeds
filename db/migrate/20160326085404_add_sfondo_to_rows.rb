class AddSfondoToRows < ActiveRecord::Migration
  def change
    add_column :rows, :colore_sfondo, :string
  end
end
