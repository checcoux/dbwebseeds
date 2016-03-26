class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :hash_secret => "hZZmdmsZZ5!76",
                    :url  => "/img/ck/:hash.:extension",
                    :path => ":rails_root/public/img/ck/:hash.:extension",
                    :styles => { :content => '800>', :thumb => '118x100#' }

  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_content_type :data, :content_type => /\Aimage/

  def url_content
    url(:content)
  end
end
