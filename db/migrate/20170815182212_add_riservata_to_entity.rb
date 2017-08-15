class AddRiservataToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :riservata, :boolean, default: true
  end
end
