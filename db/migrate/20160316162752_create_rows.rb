class CreateRows < ActiveRecord::Migration
  def change
    create_table :rows do |t|
      t.integer :ordine

      t.timestamps
    end
  end
end
