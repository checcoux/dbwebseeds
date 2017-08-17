class CambiaNomeSuProperty < ActiveRecord::Migration
  def change
    rename_column :properties, :riservato, :riservata
  end
end
