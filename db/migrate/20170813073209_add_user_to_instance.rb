class AddUserToInstance < ActiveRecord::Migration
  def change
    add_column :instances, :user_id, :integer, index:true
  end
end
