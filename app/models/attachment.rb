# singolo allegato

class Attachment < ActiveRecord::Base
  belongs_to :section
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :news, :class_name => 'Column', as: :columnable, dependent: :destroy

  has_attached_file :allegato,
                    :hash_secret => "hj42HB5!76",
                    :url  => "/files/:hash.:extension",
                    :path => ":rails_root/public/files/:hash.:extension"

  has_attached_file :immagine,
                    :hash_secret => "hj42ZZ5!76",
                    :url  => "/img/attachment/:hash.:extension",
                    :path => ":rails_root/public/img/attachment/:hash.:extension",
                    :styles => {
                        :thumb => '400x250#',
                        :small => '640>',
                        :medium => '1024>',
                        :large => '1200>',
                        :xlarge => '1920>',
                    },
                    :convert_options => {
                        :thumb => "-quality 75 -strip",
                        :small => "-quality 75 -strip",
                        :medium => "-quality 75 -strip",
                        :large => "-quality 75 -strip",
                        :xlarge => "-quality 75 -strip"
                    },
                    :default_url => "img/missing.png"

  validates_attachment_size :immagine, :less_than => 3.megabytes
  validates_attachment_content_type :immagine, :content_type => /\Aimage/

  validates_attachment_size :allegato, :less_than => 50.megabytes
  validates_attachment_content_type :allegato, :content_type => %w(
    application/pdf
    image/png image/gif image/jpeg
    application/zip application/msword application/rtf application/x-rtf application/vnd.ms-office application/vnd.ms-excel
    audio/mpeg audio/x-mpeg audio/mp3 audio/x-mp3 audio/mpeg3 audio/x-mpeg3 audio/mpg audio/x-mpg audio/x-mpegaudio
    video/mpeg video/quicktime
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
    application/vnd.openxmlformats-officedocument.wordprocessingml.document application/msword
    text/plain
  )

  self.per_page = 15
end
