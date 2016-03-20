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
json.replies post.replies do |reply|
  json.partial! 'replies/reply', reply: reply
end
json.original_post_id post.original_post_id

if post.original_post_id
	original_post = Post.find(post.original_post_id)
	json.original_post_content original_post.content
	json.original_post_author User.find(original_post.user_id).name
end