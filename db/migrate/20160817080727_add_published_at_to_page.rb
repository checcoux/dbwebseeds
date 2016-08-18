class AddPublishedAtToPage < ActiveRecord::Migration
  def change
    add_column :pages, :published_at, :datetime, default: Time.now()
  end
end
