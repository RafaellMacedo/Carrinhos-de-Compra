class CartSerializer

  def initialize(cart, options = {})
    @cart = cart
  end

  def as_json(*)
    {
      id: @cart.id,
      products: serialized_products,
      total_price: total_price
    }
  end

  private

  def serialized_products
    @cart.cart_items.includes(:product).map do |item|
      {
        id: item.product.id,
        name: item.product.name,
        quantity: item.quantity,
        unit_price: item.product.unit_price.to_f,
        total_price: (item.quantity * item.product.unit_price).to_f
      }
    end
  end

  def total_price
    serialized_products.sum { |p| p[:total_price] }
  end
end
