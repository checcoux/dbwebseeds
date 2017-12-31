class AddApplicaLimitiToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :applica_limiti, :boolean, default: false
  end
end
