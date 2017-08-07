class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :titolo
      t.string :key
      t.text :descrizione
      t.integer :user_id, index:true
      t.string :criterio1
      t.string :criterio2
      t.string :criterio3
      t.string :criterio4
      t.string :criterio5
      t.string :criterio6
      t.string :criterio7
      t.string :criterio8
      t.string :criterio9
      t.string :criterio10
      t.integer :stato, default: 1

      t.timestamps null: false
    end
  end
end
