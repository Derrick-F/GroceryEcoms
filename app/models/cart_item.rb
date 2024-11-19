class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  # Makes sure quantity or weight of a product is not nil
  after_initialize do
    self.quantity ||= 0
    self.weight ||= 0
  end

  # Calculate the total price of the cart item (before discount)
  def total_price
    if quantity.positive?
      item.price * quantity
    elsif weight.positive?
      item.price * (weight / 1000.0) # Convert grams to kilograms
    else
      0
    end
  end

  # Fetch the discount value, defaulting to 0 if not set
  def discount
    @discount || 0
  end
end
