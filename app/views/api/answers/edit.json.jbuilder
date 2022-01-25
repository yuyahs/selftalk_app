json.(@answer, :content, :created_at)

json.question do
  json.(@question, :content, :mode_num)
end

json.date @date

json.deeplKey @deepl_api_key
