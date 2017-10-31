class DropPeergrading < ActiveRecord::Migration
  def change
    drop_table :assignments
    drop_table :homeworks
    drop_table :grades
  end
end
