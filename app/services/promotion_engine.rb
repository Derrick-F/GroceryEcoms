class PromotionEngine
  def initialize(cart)
    @cart = cart
  end

  # Apply the best promotions dynamically
  def apply_best_promotions
    @cart.cart_items.each do |cart_item|
      best_promotion = find_best_promotion(cart_item)
      if best_promotion
        # Dynamically set the discount using an instance variable
        discount = calculate_discount(cart_item, best_promotion)
        cart_item.instance_variable_set(:@discount, discount)
      end
    end
  end

  def apply_buy_x_get_y(cart_item, promotion)
    return unless cart_item.quantity >= promotion.buy_quantity

    # This line Calculate eligible free items
    eligible_free_items = (cart_item.quantity / promotion.buy_quantity) * promotion.free_quantity

    # This line Calculates the discount for free items
    item_discount = cart_item.item.price * promotion.free_discount
    total_discount = [ eligible_free_items, cart_item.quantity ].min * item_discount

    total_discount
  end

  def apply_weight_threshold(cart_item, promotion)
    return 0 unless cart_item.weight && cart_item.weight >= promotion.weight_threshold

    cart_item.total_price * (promotion.value / 100.0)
  end


  def calculate_discount(cart_item, promotion)
    case promotion.promo_type
    when "flat_fee"
      # Flat discount directly from the promotion's value
      promotion.value
    when "percentage"
      # Discount is a percentage of the total price
      cart_item.total_price * (promotion.value / 100.0)
    when "buy_x_get_y"
      # Call helper for Buy X Get Y logic
      apply_buy_x_get_y(cart_item, promotion)
    when "weight_threshold"
      # Call helper for Weight Threshold Discount logic
      apply_weight_threshold(cart_item, promotion)
    else
      0
    end
  end



  private

  # Find the best applicable promotion for a cart_item
  def find_best_promotion(cart_item)
    # Fetch promotions applicable to the cart item or its category
    applicable_promotions = Promotion
      .where("start_time <= ? AND (end_time IS NULL OR end_time >= ?)", Time.current, Time.current)
      .where("item_id = ? OR category_id = ?", cart_item.item_id, cart_item.item.category_id)

    # Initialize variables to track the best promotion
    best_promotion = nil
    max_discount = 0

    # Iterate through promotions to find the best one
    applicable_promotions.each do |promotion|
      discount = calculate_discount(cart_item, promotion)

      if discount > max_discount
        max_discount = discount
        best_promotion = promotion
      end
    end

    [ best_promotion, max_discount ]
  end
end
