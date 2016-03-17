class RemoveDescrizioneFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :descrizione, :text
  end
end
