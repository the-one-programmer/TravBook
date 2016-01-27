
json.array!(@countries) do |country|
  json.id   country.id
  json.name country.name

  json.cities do
    json.array!(country.cities) do |city|
      json.id city.id
      json.name city.name
    end
  end
end