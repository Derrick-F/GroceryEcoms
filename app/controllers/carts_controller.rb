class CartsController < ApplicationController
  before_action :set_cart, only: [ :show, :add_item, :remove_item ]

  # Show the cart and its items
  def show
    @cart_items = @cart.cart_items.includes(:item)
  end

  # Add an item to the cart
  def add_item
    # Find the item to be added
    item = Item.find(params[:item_id])
    quantity = params[:quantity].to_i
    weight = params[:weight].to_f

    # Use CartService to handle the logic
    CartService.new(@cart).add_item(item, quantity, 0)
    redirect_to @cart, notice: "Item added to cart successfully!"
  end

  # Remove an item from the cart
  def remove_item
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to @cart, notice: "Item removed from cart."
  end

  private

  # Find or initialize a cart using session
  def set_cart
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end
end
