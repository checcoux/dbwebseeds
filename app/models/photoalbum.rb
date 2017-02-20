class Photoalbum < ActiveRecord::Base
  belongs_to :section

  has_many :tags, as: :taggable, dependent: :destroy

  self.per_page = 30
end
