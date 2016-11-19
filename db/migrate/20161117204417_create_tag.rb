class CreateTag < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :nome
      t.references :taggable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
