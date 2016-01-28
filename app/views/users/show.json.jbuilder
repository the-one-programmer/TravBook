json.id @user.id
json.(@user, :name, :email,:gender,:willing_to_host,:birthday)
json.city City.find(@user.city_id).name
if @user.willing_to_host
  json.(@user, :can_transport,:transport_detail,:can_tourguide,:tourguide_detail,:can_accomendation,:accomendation_detail,:can_pickup,:pickup_detail)
end
json.interests @user.interests do |interest|
  json.interest_id interest.id
  json.interest_name interest.name
end

json.languages @user.languages do |language|
  json.language_id language.id
  json.language_name language.name
end

json.countries_want_to_go @user.countries do |country|
  json.country_id country.id
  json.country_name country.name
end
