json.array!(@rows) do |row|
  json.extract! row, :id, :ordine
  json.url row_url(row, format: :json)
end
