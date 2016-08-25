class AddSectionRefToAttachments < ActiveRecord::Migration
  def change
    add_reference :attachments, :section, index: true
  end
end
