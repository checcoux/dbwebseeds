class AddHomeToPage < ActiveRecord::Migration
  def change
    add_column :pages, :home, :boolean, default: false
    add_column :pages, :header, :boolean, default: false
    add_column :pages, :footer, :boolean, default: false
  end
end
