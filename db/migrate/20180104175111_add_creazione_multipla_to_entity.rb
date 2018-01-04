class AddCreazioneMultiplaToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :creazione_multipla, :boolean, default: false
  end
end
