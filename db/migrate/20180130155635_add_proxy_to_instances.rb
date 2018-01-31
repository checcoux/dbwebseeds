class AddProxyToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :proxy, :string, default: ''
  end
end
