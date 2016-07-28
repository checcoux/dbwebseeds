class AddPrincipaleToSection < ActiveRecord::Migration
  def change
    add_column :sections, :principale, :boolean, default: false
  end
end
