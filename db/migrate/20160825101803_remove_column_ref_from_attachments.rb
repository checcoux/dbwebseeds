class RemoveColumnRefFromAttachments < ActiveRecord::Migration
  def change
    remove_column :attachments, :column_id
  end
end
