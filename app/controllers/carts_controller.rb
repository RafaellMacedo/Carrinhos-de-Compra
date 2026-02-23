class CartsController < ApplicationController
   before_action :validate_params, only: [:add_item]

  def show
    cart = current_cart
    return cart_not_exist unless cart
    
    render json: CartSerializer.new(cart), status: :ok
  end

  def add_item
    cart = current_cart || create_cart

    result = cart.add_product(
      product_id: cart_params[:product_id],
      quantity: cart_params[:quantity]
    )

    return product_not_found unless result

    render json: CartSerializer.new(cart), status: :ok
  end

  def remove_item
    cart = current_cart
    return cart_not_exist unless cart

    product_id = cart_params[:product_id]
    return missing_product_id unless product_id

    unless cart.product_exists?(product_id)
      return product_not_found
    end

    unless cart.remove_product(product_id)
      return remove_product_not_in_cart
    end

    if cart.cart_items.empty?
      return last_product_removed
    end

    render json: CartSerializer.new(cart), status: :ok
  end

  private

  def current_cart
    return Cart.find_by(id: session[:cart_id])
  end

  def create_cart
    cart = Cart.create(total_price: 0.0)
    session[:cart_id] = cart.id
    cart
  end

  def cart_params
    params.permit(:product_id, :quantity)
  end

  def validate_params
    return if cart_params[:product_id].present? && cart_params[:quantity].present?
    add_cart_required_fields
  end
  
end
