require "test_helper"

class V1::Auth::AuthControllerTest < ActionDispatch::IntegrationTest
  test "signup creates a new user and returns token" do
    post v1_auth_signup_url, params: {
      username: "newuser",
      email: "newuser@example.com",
      password: "password123",
      password_confirmation: "password123"
    }, as: :json

    assert_response :created
    json = JSON.parse(response.body)
    assert json["token"].present?
    assert_equal "newuser", json["user"]["username"]
    assert_equal "newuser@example.com", json["user"]["email"]
  end

  test "signup fails with invalid params" do
    post v1_auth_signup_url, params: {
      username: "",
      email: "bad",
      password: "short"
    }, as: :json

    assert_response :unprocessable_entity
    json = JSON.parse(response.body)
    assert json["errors"].present?
  end

  test "login returns token with valid credentials" do
    post v1_auth_login_url, params: {
      email: users(:one).email,
      password: "password123"
    }, as: :json

    assert_response :success
    json = JSON.parse(response.body)
    assert json["token"].present?
    assert_equal users(:one).email, json["user"]["email"]
  end

  test "login fails with invalid credentials" do
    post v1_auth_login_url, params: {
      email: users(:one).email,
      password: "wrongpassword"
    }, as: :json

    assert_response :unauthorized
  end

  test "logout returns no content" do
    user = users(:one)
    token = JwtService.encode(user_id: user.id)

    delete v1_auth_logout_url, headers: {
      Authorization: "Bearer #{token}"
    }

    assert_response :no_content
  end
end
