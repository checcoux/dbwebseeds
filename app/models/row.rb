class Row < ActiveRecord::Base
  belongs_to :page
  has_many :areas, dependent: :destroy

  default_scope { order('ordine ASC') }
end
