json.id post.id
json.author_id post.user_id
json.author User.find(post.user_id).name
json.content post.content
json.likes_count post.likers.count
json.likers post.likers do |liker|
  json.liker_id liker.id
  json.liker_name liker.name
end
json.type post.type
json.repost_count post.number_of_reposts