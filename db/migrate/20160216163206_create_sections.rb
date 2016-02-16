class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :titolo
      t.text :descrizione

      t.timestamps
    end
  end
end
