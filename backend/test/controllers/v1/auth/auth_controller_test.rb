require "test_helper"

class V1::Auth::AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get v1_auth_auth_signup_url
    assert_response :success
  end

  test "should get login" do
    get v1_auth_auth_login_url
    assert_response :success
  end

  test "should get logout" do
    get v1_auth_auth_logout_url
    assert_response :success
  end
end
