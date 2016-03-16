json.array!(@areas) do |area|
  json.extract! area, :id, :ordine, :contenuto
  json.url area_url(area, format: :json)
end
