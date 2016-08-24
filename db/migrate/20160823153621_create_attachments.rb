class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :titolo
      t.text :descrizione
      t.string :collegamento
      t.references :column, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
