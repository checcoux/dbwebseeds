class AddModelloToPage < ActiveRecord::Migration
  def change
    add_column :pages, :modello, :boolean, default: false
    add_column :pages, :articolo, :boolean, default: false
    add_column :pages, :visibile, :boolean, default: true
  end
end
