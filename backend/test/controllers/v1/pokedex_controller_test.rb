require "test_helper"

class V1::PokedexControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get v1_pokedex_index_url
    assert_response :success
  end
end
