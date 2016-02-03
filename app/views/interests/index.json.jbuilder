json.array!(@interests) do |interest|
  json.extract! interest, :id, :name
  json.id   interest.id
  json.name interest.name

end
