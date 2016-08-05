class AddPageRefToColumns < ActiveRecord::Migration
  def change
    add_reference :columns, :page, index: true, default: 0
  end
end
