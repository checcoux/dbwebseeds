class RemoveRuoloFromColumns < ActiveRecord::Migration
  def change
    remove_column :columns, :ruolo, :string
  end
end
