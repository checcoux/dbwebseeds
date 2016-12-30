class AddAutocropToColumns < ActiveRecord::Migration
  def change
    add_column :columns, :autocrop, :boolean, default: false
    add_column :columns, :padding, :string, default: ''
  end
end
