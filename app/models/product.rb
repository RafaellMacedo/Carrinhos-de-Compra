class Product < ApplicationRecord
  validates :name, presence: true
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  has_many :cart_items
  has_many :carts, through: :cart_items
end
