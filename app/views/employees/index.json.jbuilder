json.array!(@employees) do |employee|
  json.extract! employee, :id, :title, :first_name, :middle_name, :last_name, :bio
  json.url employee_url(employee, format: :json)
end
