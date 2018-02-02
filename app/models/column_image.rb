# immagine collegata a una colonna; nel caso di più immagini viene generato uno slider

class ColumnImage < ActiveRecord::Base
  belongs_to :column

  has_attached_file :immagine,
                    :hash_secret => "hj42ZZ5!76",
                    :url  => "/img/column/:hash.:extension",
                    :path => ":rails_root/public/img/column/:hash.:extension",
                    :styles => {
                        :thumb => ['400x250#', :jpg],
                        :small => ['640>', :jpg],
                        :medium => ['1024>', :jpg],
                        :large => ['1200>', :jpg],
                        :xlarge => ['1920>', :jpg],
                    },
                    :convert_options => {
                        :thumb => "-quality 75 -strip",
                        :small => "-quality 75 -strip",
                        :medium => "-quality 75 -strip",
                        :large => "-quality 75 -strip",
                        :xlarge => "-quality 75 -strip"
                    },
                    :default_url => "img/missing.png"

  validates_attachment_size :immagine, :less_than => 8.megabytes
  validates_attachment_content_type :immagine, :content_type => /\Aimage/
end
