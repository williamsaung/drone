require 'test_helper'

class MissionRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mission_record = mission_records(:one)
  end

  test "should get index" do
    get mission_records_url
    assert_response :success
  end

  test "should get new" do
    get new_mission_record_url
    assert_response :success
  end

  test "should create mission_record" do
    assert_difference('MissionRecord.count') do
      post mission_records_url, params: { mission_record: { drone_id: @mission_record.drone_id, latitude: @mission_record.latitude, longitude: @mission_record.longitude } }
    end

    assert_redirected_to mission_record_url(MissionRecord.last)
  end

  test "should show mission_record" do
    get mission_record_url(@mission_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_mission_record_url(@mission_record)
    assert_response :success
  end

  test "should update mission_record" do
    patch mission_record_url(@mission_record), params: { mission_record: { drone_id: @mission_record.drone_id, latitude: @mission_record.latitude, longitude: @mission_record.longitude } }
    assert_redirected_to mission_record_url(@mission_record)
  end

  test "should destroy mission_record" do
    assert_difference('MissionRecord.count', -1) do
      delete mission_record_url(@mission_record)
    end

    assert_redirected_to mission_records_url
  end
end
