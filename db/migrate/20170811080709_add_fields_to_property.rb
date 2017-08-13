class AddFieldsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :riservato, :boolean
    add_column :properties, :condizioni, :string
    add_column :properties, :ordine, :integer
    add_column :properties, :descrizione, :text
    add_column :properties, :placeholder, :string
    add_column :properties, :default, :string
  end
end
