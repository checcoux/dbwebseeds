class AddUserToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :user_id, :integer, index:true
    add_column :entities, :landing_page, :string
  end
end
