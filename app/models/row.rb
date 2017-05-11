# ogni riga contiene diverse colonne e appartiene a una pagina

class Row < ActiveRecord::Base
  belongs_to :page
  has_many :columns, dependent: :destroy

  has_attached_file :immagine_sfondo,
                    :hash_secret => "hj42ZZ5!76",
                    :url  => "/img/sfondi/:hash.:extension",
                    :path => ":rails_root/public/img/sfondi/:hash.:extension",
                    :styles => { :content => '1800>', :thumb => '118x100#' }

  validates_attachment_size :immagine_sfondo, :less_than => 3.megabytes
  validates_attachment_content_type :immagine_sfondo, :content_type => /\Aimage/
end
