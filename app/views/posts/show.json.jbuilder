json.id @post.id
json.author_id @post.user_id
json.author User.find(@post.user_id).name
json.content @post.content
json.likes_count @post.likers.count
json.likers @post.likers do |liker|
  json.liker_id liker.id
  json.liker_name liker.name
end