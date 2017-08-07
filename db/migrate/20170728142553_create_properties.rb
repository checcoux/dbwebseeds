class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :nome, index: true
      t.string :tipo
      t.boolean :nativo, default: false
      t.integer :entity_id, index:true

      t.timestamps null: false
    end
  end
end
