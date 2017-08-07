class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.integer :entity_id
      t.integer :section_id
      t.string :tags

      t.timestamps null: false
    end
  end
end
