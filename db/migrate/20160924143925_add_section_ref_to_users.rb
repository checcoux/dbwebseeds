class AddSectionRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :section
  end
end
