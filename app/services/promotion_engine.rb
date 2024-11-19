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

  private

  # Find the best applicable promotion for a cart_item
  def find_best_promotion(cart_item)
    # Logic to find the best promotion for this item
    # This could include checking item-specific and category-wide promotions
    Promotion.where("start_time <= ? AND (end_time IS NULL OR end_time >= ?)", Time.current, Time.current)
             .where("item_id = ? OR category_id = ?", cart_item.item_id, cart_item.item.category_id)
             .order(:promo_type, :value)
             .first # Replace with logic to pick the "best" promotion
  end

  # Calculate the discount based on the promotion type
  def calculate_discount(cart_item, promotion)
    case promotion.promo_type
    when "flat_fee"
      promotion.value
    when "percentage"
      (cart_item.total_price * (promotion.value / 100)).round(2)
    when "buy_x_get_y"
      # Example: Assume Buy 1 Get 1 Free for simplicity
      cart_item.quantity >= 2 ? cart_item.item.price : 0
    when "weight_threshold"
      cart_item.weight >= 100 ? (cart_item.total_price * (promotion.value / 100)).round(2) : 0
    else
      0
    end
  end
end
