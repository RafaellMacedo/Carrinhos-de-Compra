class CartsController < ApplicationController

  def show
    cart = take_current_cart

    return cart_not_exist unless cart
    
    render json: CartSerializer.new(cart), status: :ok
  end

  def add_product
    return add_cart_required_fields unless validate_request

    cart = verify_and_create_cart

    return add_cart_product_not_found unless save_product_cart_item(cart)

    cart.update_total_price

    render json: {
      id: cart.id,
      products: cart.cart_items.map do |item|
        {
          id: item.product.id,
          name: item.product.name,
          quantity: item.quantity,
          unit_price: item.price.to_f,
          total_price: (item.price * item.quantity).to_f
        }
      end,
      total_price: cart.total_price.to_f
    }
  end

  private

  def verify_and_create_cart
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id]) || Cart.create(total_price: 0.0)
    else
      cart = Cart.create(total_price: 0.0)
    end

    session[:cart_id] = cart.id
    
    cart
  end

  def save_product_cart_item(cart)
    product = Product.find_by(id: params[:product_id])

    return false unless product

    cart_item = cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity += params[:quantity].to_i
    cart_item.price = product.unit_price
    cart_item.save!
  end

  def validate_request
      unless params.permit(:product_id).present? && params.permit(:quantity).present?
          return false
      end
      return true
  end
  
  def take_current_cart
    return Cart.find_by(id: session[:cart_id]) if session[:cart_id]
  end
end
