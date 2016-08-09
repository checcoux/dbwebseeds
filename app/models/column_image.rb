class ColumnImage < ActiveRecord::Base
  belongs_to :column

  has_attached_file :immagine,
                    :hash_secret => "hj42ZZ5!76",
                    :url  => "/img/column/:hash.:extension",
                    :path => ":rails_root/public/img/column/:hash.:extension",
                    :styles => { :content => '1800>', :thumb => '118x100#' },
                    :default_url => "img/missing.png"

  validates_attachment_size :immagine, :less_than => 3.megabytes
  validates_attachment_content_type :immagine, :content_type => /\Aimage/
end
