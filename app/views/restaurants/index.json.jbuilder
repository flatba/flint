json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :category, :price, :star, :area, :image
  json.url restaurant_url(restaurant, format: :json)
end
