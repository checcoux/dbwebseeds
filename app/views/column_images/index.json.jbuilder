json.array!(@column_images) do |column_image|
  json.extract! column_image, :id, :descrizione, :column_id
  json.url column_image_url(column_image, format: :json)
end
