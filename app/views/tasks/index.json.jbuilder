json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :date, :done, :type, :info
  json.url task_url(task, format: :json)
end
