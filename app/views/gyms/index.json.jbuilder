json.array!(@gyms) do |gym|
  json.extract! gym, :id, :name, :phone, :email, :fax
  json.url gym_url(gym, format: :json)
end
