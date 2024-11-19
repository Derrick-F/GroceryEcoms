class CartService
  # Service object to assist with carts
  def initialize(cart)
    @cart = cart
  end

  def add_item(item, quantity, weight)
    # Find or initialize a CartItem for the given item
    cart_item = @cart.cart_items.find_or_initialize_by(item: item)

    # Update quantity or weight based on unit type
    if item.unit_type == "weight"
      cart_item.weight = (cart_item.weight || 0) + weight
    else
      cart_item.quantity = (cart_item.quantity || 0) + quantity
    end

    cart_item.save!
  end
end
