class AddParoleToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :parole, :text
  end
end
