require "test_helper"

class V1::PokedexControllerTest < ActionDispatch::IntegrationTest
  setup do
    @token = JwtService.encode(user_id: users(:one).id)
  end

  test "should get index" do
    get v1_pokedex_index_url, headers: { "Authorization" => "Bearer #{@token}" }
    assert_response :success
  end
end
