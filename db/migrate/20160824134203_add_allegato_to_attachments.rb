class AddAllegatoToAttachments < ActiveRecord::Migration
  def change
    add_attachment :attachments, :allegato
  end
end
