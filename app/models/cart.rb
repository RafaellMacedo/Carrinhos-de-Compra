class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def update_total_price
    self.total_price = cart_items.sum('price * quantity')
    save
  end

  # TODO: lógica para marcar o carrinho como abandonado e remover se abandonado
end
