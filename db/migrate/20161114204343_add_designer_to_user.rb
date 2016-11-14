class AddDesignerToUser < ActiveRecord::Migration
  def change
    add_column :users, :designer, :boolean, default: false
  end
end
