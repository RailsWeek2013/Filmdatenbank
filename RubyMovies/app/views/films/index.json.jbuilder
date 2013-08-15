json.array!(@films) do |film|
  json.extract! film, :title, :picture, :description, :link
  json.url film_url(film, format: :json)
end
