json.array!(@events) do |event|
  json.extract! event, :id, :start, :end, :name, :description, :reoccurs_every, :user_id
  json.url event_url(event, format: :json)
end
