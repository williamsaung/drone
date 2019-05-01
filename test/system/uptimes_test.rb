require "application_system_test_case"

class UptimesTest < ApplicationSystemTestCase
  setup do
    @uptime = uptimes(:one)
  end

  test "visiting the index" do
    visit uptimes_url
    assert_selector "h1", text: "Uptimes"
  end

  test "creating a Uptime" do
    visit uptimes_url
    click_on "New Uptime"

    fill_in "End Time", with: @uptime.end_time
    fill_in "Mission", with: @uptime.mission_id
    fill_in "Start Time", with: @uptime.start_time
    click_on "Create Uptime"

    assert_text "Uptime was successfully created"
    click_on "Back"
  end

  test "updating a Uptime" do
    visit uptimes_url
    click_on "Edit", match: :first

    fill_in "End Time", with: @uptime.end_time
    fill_in "Mission", with: @uptime.mission_id
    fill_in "Start Time", with: @uptime.start_time
    click_on "Update Uptime"

    assert_text "Uptime was successfully updated"
    click_on "Back"
  end

  test "destroying a Uptime" do
    visit uptimes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Uptime was successfully destroyed"
  end
end
