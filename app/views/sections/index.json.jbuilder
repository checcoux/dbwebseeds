json.array!(@sections) do |section|
  json.extract! section, :id, :titolo, :descrizione
  json.url section_url(section, format: :json)
end
