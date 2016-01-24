json.array!(@interests) do |interest|
  json.id   interest.id
  json.name interest.name

end
