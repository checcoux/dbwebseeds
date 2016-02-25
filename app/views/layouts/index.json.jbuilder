json.array!(@layouts) do |layout|
  json.extract! layout, :id, :titolo
  json.url layout_url(layout, format: :json)
end
