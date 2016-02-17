class Section < ActiveRecord::Base
  validates :titolo, :descrizione, presence: true
end
