Rack::Attack.throttle('limit status per request', limit: 1, period: 60.seconds) do |req|
  if req.path == 'drone/mission_status_change' && req.put?
    req.params['mission_status']
  end
end