class AddColumnableToColumns < ActiveRecord::Migration
  def change
    add_reference :columns, :columnable, polymorphic: true, index: true
  end
end
