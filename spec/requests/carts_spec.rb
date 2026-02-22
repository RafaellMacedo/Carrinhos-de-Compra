require 'rails_helper'

RSpec.describe "Controler Carts", type: :request do
  # let!(:product) { Product.create!(name: "TV Samsung 55", unit_price: 1300.0, quantity: 10) }
  # let!(:product) { Product.create!(name: "Celular Moto X", unit_price: 800.0, quantity: 10) }
  # let!(:product) { Product.create!(name: "Powerbank 3000mAh", unit_price: 100.0, quantity: 10) }

  # pending "TODO: Escreva os testes de comportamento do controller de carrinho necessários para cobrir a sua implmentação #{__FILE__}"

  # describe "POST /add_items" do
  #   let(:cart) { Cart.create }
  #   let(:product) { Product.create(name: "Test Product", price: 10.0) }
  #   let!(:cart_item) { CartItem.create(cart: cart, product: product, quantity: 1) }

  #   context 'when the product already is in the cart' do
  #     subject do
  #       post '/cart/add_items', params: { product_id: product.id, quantity: 1 }, as: :json
  #       post '/cart/add_items', params: { product_id: product.id, quantity: 1 }, as: :json
  #     end

  #     it 'updates the quantity of the existing item in the cart' do
  #       expect { subject }.to change { cart_item.reload.quantity }.by(2)
  #     end
  #   end
  # end

  describe "POST /cart" do
    let!(:product) { Product.create!(name: "TV Samsung 55", unit_price: 1300.0, quantity: 10) }

    it "Store New Product in Cart" do
      post "/cart",
           params: {
             product_id: product.id,
             quantity: 2
           },
           as: :json

      expect(response).to have_http_status(:ok)
    end

    it "Not save new product in Cart when Product Not Found" do
      post "/cart",
           params: {
             product_id: product.id+1,
             quantity: 2
           },
           as: :json

      expect(response).to have_http_status(:not_found)
    end

    it "does not save product when product_id is missing" do
      post "/cart",
           params: {
             quantity: 2
           },
           as: :json

      expect(response).to have_http_status(:bad_request)
    end

    it "does not save product when quantity is missing" do
      post "/cart",
           params: {
             product_id: product.id
           },
           as: :json

      expect(response).to have_http_status(:bad_request)
    end
  end
end
