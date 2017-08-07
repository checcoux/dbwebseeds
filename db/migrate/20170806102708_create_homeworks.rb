class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.integer :assignment_id, index:true
      t.integer :user_id, index:true
      t.string :url
      t.text :note
      t.decimal :voto

      t.timestamps null: false
    end
  end
end
