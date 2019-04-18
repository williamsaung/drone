require 'test_helper'

class PolygonControllerTest < ActionDispatch::IntegrationTest
  test "should get polygon" do
    get polygon_polygon_url
    assert_response :success
  end

end
