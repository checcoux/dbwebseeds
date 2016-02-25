class AddLayoutRefToPages < ActiveRecord::Migration
  def change
    add_reference :pages, :layout, index: true
  end
end
