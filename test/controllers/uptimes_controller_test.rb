require 'test_helper'

class UptimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @uptime = uptimes(:one)
  end

  test "should get index" do
    get uptimes_url
    assert_response :success
  end

  test "should get new" do
    get new_uptime_url
    assert_response :success
  end

  test "should create uptime" do
    assert_difference('Uptime.count') do
      post uptimes_url, params: { uptime: { end_time: @uptime.end_time, mission_id: @uptime.mission_id, start_time: @uptime.start_time } }
    end

    assert_redirected_to uptime_url(Uptime.last)
  end

  test "should show uptime" do
    get uptime_url(@uptime)
    assert_response :success
  end

  test "should get edit" do
    get edit_uptime_url(@uptime)
    assert_response :success
  end

  test "should update uptime" do
    patch uptime_url(@uptime), params: { uptime: { end_time: @uptime.end_time, mission_id: @uptime.mission_id, start_time: @uptime.start_time } }
    assert_redirected_to uptime_url(@uptime)
  end

  test "should destroy uptime" do
    assert_difference('Uptime.count', -1) do
      delete uptime_url(@uptime)
    end

    assert_redirected_to uptimes_url
  end
end
