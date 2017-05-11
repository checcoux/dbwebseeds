# modello per le immagini inserite negli editor

class Ckeditor::Picture < Ckeditor::Asset
  belongs_to :assetable, polymorphic: true

  has_attached_file :data,
                    :hash_secret => "hZZmdmsZZ5!76",
                    :url  => "/img/ck/:hash.:extension",
                    :path => ":rails_root/public/img/ck/:hash.:extension",
                    :styles => { :content => '1200>', :thumb => '150>' },
                    :convert_options => {
                        :thumb => "-quality 75 -strip",
                        :content => "-quality 75 -strip",
                    },
                    :default_url => "img/missing.png"

  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_content_type :data, :content_type => /\Aimage/

  def url_content
    url(:content)
  end
end
