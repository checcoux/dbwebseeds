class AddSectionRefToPages < ActiveRecord::Migration
  def change
    add_reference :pages, :section, index: true
  end
end
