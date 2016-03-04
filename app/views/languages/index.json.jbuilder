json.array!(@languages) do |language|
  json.id   language.id
  json.name language.name
end
