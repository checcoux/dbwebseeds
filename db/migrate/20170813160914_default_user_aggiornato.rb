class DefaultUserAggiornato < ActiveRecord::Migration
  def change
    change_column :users, :aggiornato, :boolean, default: false
  end
end
