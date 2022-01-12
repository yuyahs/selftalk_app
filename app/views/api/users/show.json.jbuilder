json.(@user, :name , :email, :password, :password_confirmation)

json.learning @learning_days

json.sequential_days @sequential_days

json.dates do
  json.array! @dates
end

json.days do
  json.array! @wdays
end

json.contributions do
  json.array! @contributions
end
