require "application_system_test_case"

class PromotionsTest < ApplicationSystemTestCase
  setup do
    @promotion = promotions(:one)
  end

  test "visiting the index" do
    visit promotions_url
    assert_selector "h1", text: "Promotions"
  end

  test "should create promotion" do
    visit promotions_url
    click_on "New promotion"

    fill_in "Category", with: @promotion.category_id
    fill_in "End time", with: @promotion.end_time
    fill_in "Item", with: @promotion.item_id
    fill_in "Promo type", with: @promotion.promo_type
    fill_in "Start time", with: @promotion.start_time
    fill_in "Value", with: @promotion.value
    click_on "Create Promotion"

    assert_text "Promotion was successfully created"
    click_on "Back"
  end

  test "should update Promotion" do
    visit promotion_url(@promotion)
    click_on "Edit this promotion", match: :first

    fill_in "Category", with: @promotion.category_id
    fill_in "End time", with: @promotion.end_time.to_s
    fill_in "Item", with: @promotion.item_id
    fill_in "Promo type", with: @promotion.promo_type
    fill_in "Start time", with: @promotion.start_time.to_s
    fill_in "Value", with: @promotion.value
    click_on "Update Promotion"

    assert_text "Promotion was successfully updated"
    click_on "Back"
  end

  test "should destroy Promotion" do
    visit promotion_url(@promotion)
    click_on "Destroy this promotion", match: :first

    assert_text "Promotion was successfully destroyed"
  end
end
