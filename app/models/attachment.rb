class Attachment < ActiveRecord::Base
  belongs_to :column
  belongs_to :section

  has_attached_file :allegato,
                    :hash_secret => "hj42HB5!76",
                    :url  => "/files/:hash.:extension",
                    :path => ":rails_root/public/files/:hash.:extension"

  validates_attachment_size :allegato, :less_than => 50.megabytes
  validates_attachment_content_type :allegato, :content_type => %w(
    application/pdf
    image/png image/gif image/jpeg
    application/zip application/msword application/vnd.ms-office application/vnd.ms-excel
    audio/mpeg audio/x-mpeg audio/mp3 audio/x-mp3 audio/mpeg3 audio/x-mpeg3 audio/mpg audio/x-mpg audio/x-mpegaudio
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
    application/vnd.openxmlformats-officedocument.wordprocessingml.document application/msword
    text/plain
  )

  self.per_page = 15
end
