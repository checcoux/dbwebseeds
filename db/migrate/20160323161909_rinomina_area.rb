class RinominaArea < ActiveRecord::Migration
  def change
    rename_table :areas, :columns
  end
end
