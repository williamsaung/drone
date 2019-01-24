json.extract! location, :id, :name, :latitude, :longitude, :created_at, :updated_at
json.url location_url(location, format: :json)
