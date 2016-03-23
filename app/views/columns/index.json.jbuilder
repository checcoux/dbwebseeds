json.array!(@columns) do |column|
  json.extract! column, :id, :ordine, :contenuto
  json.url column_url(column, format: :json)
end
