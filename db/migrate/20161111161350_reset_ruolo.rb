class ResetRuolo < ActiveRecord::Migration
  def change
    Column.update_all(:ruolo => nil)
  end
end
