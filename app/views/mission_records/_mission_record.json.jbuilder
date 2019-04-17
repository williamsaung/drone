json.extract! mission_record, :id, :latitude, :longitude, :drone_id, :created_at, :updated_at
json.url mission_record_url(mission_record, format: :json)
