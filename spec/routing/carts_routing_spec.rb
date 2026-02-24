require "rails_helper"

RSpec.describe CartsController, type: :routing do
  describe 'routes' do
    it 'routes to #show' do
      expect(get: '/cart').to route_to('carts#show')
    end

    it 'routes to #create' do
      expect(post: "/cart").to route_to("carts#add_item")
    end

    it 'routes to #add_item via POST' do
      expect(put: '/cart/add_item').to route_to('carts#add_item')
    end

    it "routes PATCH /cart/:product_id to carts#remove_item" do
      expect(patch: "/cart/10").to route_to(
        controller: "carts",
        action: "remove_item",
        product_id: "10"
      )
    end
  end
end 
