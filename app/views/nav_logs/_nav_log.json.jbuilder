json.extract! nav_log, :id, :altitude, :gps_latitude, :gps_longitude, :drone_id, :created_at, :updated_at
json.url nav_log_url(nav_log, format: :json)
