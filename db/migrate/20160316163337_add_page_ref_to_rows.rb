class AddPageRefToRows < ActiveRecord::Migration
  def change
    add_reference :rows, :page, index: true
  end
end
