class Row < ActiveRecord::Base
  belongs_to :page
  has_many :columns, dependent: :destroy

  default_scope { order('ordine ASC') }
end
