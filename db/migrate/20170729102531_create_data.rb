class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.integer :instance_id
      t.integer :property_id
      t.string :valore

      t.timestamps null: false
    end
  end
end
