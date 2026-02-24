require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'when validating' do
    it 'validates numericality of total_price' do
      cart = described_class.new(total_price: -1)
      expect(cart.valid?).to be_falsey
      expect(cart.errors[:total_price]).to include("must be greater than or equal to 0")
    end
  end

  describe 'mark_as_abandoned' do
    let(:cart) { Cart.create(total_price: 0.0) }
    let(:product) { Product.create!(name: "Test Product", unit_price: 10.0, quantity: 10) }
    let!(:cart_item) { CartItem.create!(cart: cart, product: product, quantity: 1, price: product.unit_price) }

    it 'marks the shopping cart as abandoned if inactive for a certain time' do
      cart.update(last_interaction_at: 3.hours.ago)
      expect { cart.mark_as_abandoned }.to change { cart.abandoned? }.from(false).to(true)
    end
  end

  describe 'remove_if_abandoned' do
    let(:cart) { Cart.create(total_price: 0.0) }
    let(:product) { Product.create!(name: "Test Product", unit_price: 10.0, quantity: 10) }
    let!(:cart_item) { CartItem.create!(cart: cart, product: product, quantity: 1, price: product.unit_price) }
    
    it 'removes the shopping cart if abandoned for a certain time' do
      # Precisei faze rum reload porque o objeto cart foi criado antes de do cart_item, com isso como ele esta 
      #    cacheado, precisei fazer um reload para atualizar o objeto, para assim, quando for chamado os métodos
      #    mark_as_abandoned e remove_if_abandoned vai ser verificado no destroy que tem cart_items dentro do cart
      #    e remover os cart_items e depois o cart.
      cart.reload
      cart.update(last_interaction_at: 8.days.ago)
      cart.mark_as_abandoned
      expect { cart.remove_if_abandoned }.to change { Cart.count }.by(-1)
    end
  end
end
