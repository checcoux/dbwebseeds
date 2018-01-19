class AddGratuitaCapigruppoToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :capogruppo_gratuito, :integer, default: 0
  end
end
