class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :homework_id, index:true
      t.integer :user_id, index:true
      t.integer :p1
      t.integer :p2
      t.integer :p3
      t.integer :p4
      t.integer :p5
      t.integer :p6
      t.integer :p7
      t.integer :p8
      t.integer :p9
      t.integer :p10
      t.text :note
      t.decimal :voto

      t.timestamps null: false
    end
  end
end
