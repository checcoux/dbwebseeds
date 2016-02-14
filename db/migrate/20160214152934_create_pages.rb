class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :titolo
      t.text :descrizione

      t.timestamps
    end
  end
end
