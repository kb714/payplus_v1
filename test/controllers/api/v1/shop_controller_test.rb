require 'test_helper'

class Api::V1::ShopControllerTest < ActionDispatch::IntegrationTest
  test "should get Shop" do
    get api_v1_shop_Shop_url
    assert_response :success
  end

  test "should get store" do
    get api_v1_shop_store_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_shop_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_shop_destroy_url
    assert_response :success
  end

end
