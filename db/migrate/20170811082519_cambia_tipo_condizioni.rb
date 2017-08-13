class CambiaTipoCondizioni < ActiveRecord::Migration
  def change
    change_column :properties, :condizioni, :text
  end
end
