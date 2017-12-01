# singola colonna di una pagina, appartiene a una riga

class Column < ActiveRecord::Base
  belongs_to :row
  belongs_to :page
  belongs_to :columnable, polymorphic: true
  has_many :column_images, dependent: :destroy
end