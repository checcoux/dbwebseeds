class AddVetrinaToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :vetrina, :boolean, default: false
    remove_column :entities, :riservata, :boolean
    add_column :entities, :stato, :integer, default: 0
    add_column :entities, :descrizione, :text, default: ''
    add_column :entities, :date, :string, default: ''
  end
end
