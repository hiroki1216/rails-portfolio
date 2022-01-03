require "test_helper"

class TalksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get talks_show_url
    assert_response :success
  end

  test "should get create" do
    get talks_create_url
    assert_response :success
  end
end
