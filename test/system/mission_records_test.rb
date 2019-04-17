require "application_system_test_case"

class MissionRecordsTest < ApplicationSystemTestCase
  setup do
    @mission_record = mission_records(:one)
  end

  test "visiting the index" do
    visit mission_records_url
    assert_selector "h1", text: "Mission Records"
  end

  test "creating a Mission record" do
    visit mission_records_url
    click_on "New Mission Record"

    fill_in "Drone", with: @mission_record.drone_id
    fill_in "Latitude", with: @mission_record.latitude
    fill_in "Longitude", with: @mission_record.longitude
    click_on "Create Mission record"

    assert_text "Mission record was successfully created"
    click_on "Back"
  end

  test "updating a Mission record" do
    visit mission_records_url
    click_on "Edit", match: :first

    fill_in "Drone", with: @mission_record.drone_id
    fill_in "Latitude", with: @mission_record.latitude
    fill_in "Longitude", with: @mission_record.longitude
    click_on "Update Mission record"

    assert_text "Mission record was successfully updated"
    click_on "Back"
  end

  test "destroying a Mission record" do
    visit mission_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mission record was successfully destroyed"
  end
end
