require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe "associations" do
    it "belongs to cart" do
      expect(CartItem.reflect_on_association(:cart).macro).to eq(:belongs_to)
    end

    it "is invalid without quantity" do
      item = CartItem.new(quantity: nil)
      expect(item).not_to be_valid
    end

    it "does not allow quantity <= 0" do
      item = CartItem.new(quantity: 0)
      item.validate
      expect(item.errors[:quantity]).to be_present
    end

    it "sets price from product" do
      product = Product.create!(name: "Pen", unit_price: 10, quantity: 5)
      cart = Cart.create!

      item = CartItem.create!(cart: cart, product: product, quantity: 2, price: product.unit_price)
      
      expect(item.price).to eq(10)
    end

    it "does not allow quantity greater than stock" do
      product = Product.create!(name: "Pen", unit_price: 10, quantity: 2)
      cart = Cart.create!

      item = CartItem.new(cart: cart, product: product, quantity: 5)
      expect(item).not_to be_valid
    end
  end
end