class RemoveCollegamentoFromAttachments < ActiveRecord::Migration
  def change
    remove_column :attachments, :collegamento
  end
end
