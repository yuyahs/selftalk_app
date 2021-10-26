json.(@user, :name , :email, :password, :password_confirmation)

json.dates do
  json.array! @dates
end

