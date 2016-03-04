json.id reply.id
json.author_id reply.user.id
json.author_name reply.user.name
json.content reply.content
json.reply_to_id reply.reply_to
if (reply.reply_to != nil)
  json.reply_to_name User.find_by_id(reply.reply_to).name
end

