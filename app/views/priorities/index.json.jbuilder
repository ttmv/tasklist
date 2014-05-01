json.array!(@priorities) do |priority|
  json.extract! priority, :id, :value, :description
  json.url priority_url(priority, format: :json)
end
