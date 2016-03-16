class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer :ordine
      t.text :contenuto

      t.timestamps
    end
  end
end
