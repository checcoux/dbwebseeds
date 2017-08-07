class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :label, index: true
      t.boolean :nativo, default: false

      t.timestamps null: false
    end
  end
end
