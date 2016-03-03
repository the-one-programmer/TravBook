json.id @post.id
json.author_id @post.user_id
json.author User.find(@post.user_id).name
json.content @post.content