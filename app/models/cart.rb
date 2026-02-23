class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_id:, quantity:)
    product = Product.find_by(id: product_id)
    return false unless product

    item = cart_items.find_or_initialize_by(product: product)

    if item.id.present?
      item.quantity += quantity.to_i
    else
      item.quantity = quantity.to_i
    end

    item.price = product.unit_price
    item.save!

    update_total_price
  end

  def product_exists?(product_id)
    Product.exists?(product_id)
  end

  def remove_product(product_id)
    item = cart_items.find_by(product_id: product_id)
    return false unless item
    item.destroy
    update_total_price
  end

  def update_total_price
    self.total_price = cart_items.sum('price * quantity')
    save
  end

  # TODO: lógica para marcar o carrinho como abandonado e remover se abandonado
end
