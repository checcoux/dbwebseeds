class Section < ActiveRecord::Base
  validates :titolo, :descrizione, presence: true

  has_many :pages, dependent: :destroy
end
