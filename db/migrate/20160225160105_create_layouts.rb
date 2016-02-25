class CreateLayouts < ActiveRecord::Migration
  def change
    create_table :layouts do |t|
      t.text :titolo

      t.timestamps
    end
  end
end
