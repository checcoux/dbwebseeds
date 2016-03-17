json.array!(@pages) do |page|
  json.extract! page, :id, :titolo
  json.url page_url(page, format: :json)
end
