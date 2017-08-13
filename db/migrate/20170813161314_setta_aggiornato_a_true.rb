class SettaAggiornatoATrue < ActiveRecord::Migration
  def change
    change_column :users, :aggiornato, :boolean, default: true

    # agli utenti esistenti non richiediamo di aggiornare subito il profilo:
    # deve prima essere definita l'Entity "profilo"
    User.update_all(aggiornato: true)
  end
end
