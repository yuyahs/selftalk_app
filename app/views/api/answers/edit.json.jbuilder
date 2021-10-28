json.(@answer, :content, :created_at)

json.question do
  json.(@question, :content)
end

json.date @date
