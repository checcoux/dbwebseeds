json.extract! homework, :id, :assignment_id, :user_id, :url, :note, :voto, :created_at, :updated_at
json.url homework_url(homework, format: :json)