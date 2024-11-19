class CartsController < ApplicationController
  before_action :set_cart, only: [ :show, :add_item, :remove_item ]

  # Show the cart and its items
  def show
    @cart_items = @cart.cart_items.includes(:item)
    # Uses a service object to apply promotions to the cart items
    PromotionEngine.new(@cart).apply_best_promotions
  end

  # Add an item to the cart
  def add_item
    item = Item.find(params[:item_id])

    if item.sold_by_weight?
      weight = params[:weight].to_f
      if weight > 0
        CartService.new(@cart).add_item(item, 0, weight) # when quantity = 0, Weight is passed
        redirect_to @cart, notice: "Item added to cart successfully!"
      else
        redirect_to items_path, alert: "Please specify a valid weight for #{item.name}."
      end
    else
      quantity = params[:quantity].to_i
      if quantity > 0
        CartService.new(@cart).add_item(item, quantity, 0) # when Weight = 0, Quantity is passed
        redirect_to @cart, notice: "Item added to cart successfully!"
      else
        redirect_to items_path, alert: "Please specify a valid quantity for #{item.name}."
      end
    end
  end


  # Remove an item from the cart but also have a rescue if for some reason it cant be found or destroyed
  def remove_item
    cart_item = CartItem.find_by(id: params[:id])
    if cart_item
      cart_item.destroy
      redirect_to cart_path(params[:cart_id]), notice: "#{cart_item.item.name} was removed from the cart."
    else
      redirect_to cart_path(params[:cart_id]), alert: "Item not found in the cart."
    end
  end

  private

  # Find or initialize a cart using session
  def set_cart
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end
end
