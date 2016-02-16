json.users @users.each do |user|
  json.partial! 'users/simple_user', user: user
end