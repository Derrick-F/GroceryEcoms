require "test_helper"

class PromotionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @promotion = promotions(:one)
  end

  test "should get index" do
    get promotions_url
    assert_response :success
  end

  test "should get new" do
    get new_promotion_url
    assert_response :success
  end

  test "should create promotion" do
    assert_difference("Promotion.count") do
      post promotions_url, params: { promotion: { category_id: @promotion.category_id, end_time: @promotion.end_time, item_id: @promotion.item_id, promo_type: @promotion.promo_type, start_time: @promotion.start_time, value: @promotion.value } }
    end

    assert_redirected_to promotion_url(Promotion.last)
  end

  test "should show promotion" do
    get promotion_url(@promotion)
    assert_response :success
  end

  test "should get edit" do
    get edit_promotion_url(@promotion)
    assert_response :success
  end

  test "should update promotion" do
    patch promotion_url(@promotion), params: { promotion: { category_id: @promotion.category_id, end_time: @promotion.end_time, item_id: @promotion.item_id, promo_type: @promotion.promo_type, start_time: @promotion.start_time, value: @promotion.value } }
    assert_redirected_to promotion_url(@promotion)
  end

  test "should destroy promotion" do
    assert_difference("Promotion.count", -1) do
      delete promotion_url(@promotion)
    end

    assert_redirected_to promotions_url
  end
end
