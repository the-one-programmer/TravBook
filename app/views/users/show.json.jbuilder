json.id @user.id
json.(@user, :name, :email,:gender,:willing_to_host,:birthday)
json.city City.find(@user.city_id).name
if @user.willing_to_host
  json.(@user, :can_transport,:transport_detail,:can_tourguide,:tourguide_detail,:can_accomendation,:accomendation_detail,:can_pickup,:pickup_detail)
end
json.avatar @user.avatar.url
json.interests @user.interests.collect { |d| d.id }
json.languages @user.languages.collect { |d| d.id }
json.countries_want_to_go @user.countries.collect { |d| d.id }
json.followeds @user.followeds do |followed|
  json.followed_id followed.id
  json.followed_name followed.name
end
json.followers @user.followers do |follower|
  json.follower_id follower.id
  json.follower_name follower.name
end