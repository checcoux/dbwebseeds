# singola foto di un photoalbum

class Photo < ActiveRecord::Base
  mount_uploader :immagine, PhotoUploader
  belongs_to :photoalbum
end
