class RemoveTimestampsFromProperties < ActiveRecord::Migration
  def change
    remove_column :properties, :created_at, :string
    remove_column :properties, :updated_at, :string
  end
end
