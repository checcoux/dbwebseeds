json.extract! photo, :id, :photoalbum_id, :immagine, :created_at, :updated_at
json.url photo_url(photo, format: :json)