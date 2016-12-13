json.extract! statistic, :id, :name, :user_id, :department_id, :units, :created_at, :updated_at
json.url statistic_url(statistic, format: :json)