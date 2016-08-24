json.array!(@attachments) do |attachment|
  json.extract! attachment, :id, :titolo, :descrizione
  json.url attachment_url(attachment, format: :json)
end
