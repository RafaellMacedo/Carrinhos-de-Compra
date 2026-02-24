require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe AbandonedCartsJob, type: :job do
  before do
    Sidekiq::Testing.inline!
  end

  let!(:active_cart) { Cart.create!(total_price: 100.0, last_interaction_at: 1.hour.ago, abandoned: false) }
  let!(:old_cart)    { Cart.create!(total_price: 50.0, last_interaction_at: 8.days.ago, abandoned: true) }
  let!(:stale_cart)  { Cart.create!(total_price: 75.0, last_interaction_at: 4.hours.ago, abandoned: false) }

  it "marks carts inactive for more than 3 hours as abandoned" do
    expect {
      AbandonedCartsJob.perform_now
    }.to change { stale_cart.reload.abandoned }.from(false).to(true)
  end

  it "does not mark recently active carts as abandoned" do
    expect {
      AbandonedCartsJob.perform_now
    }.not_to change { active_cart.reload.abandoned }
  end

  it "destroys carts abandoned for more than 7 days" do
    expect {
      AbandonedCartsJob.perform_now
    }.to change { Cart.exists?(old_cart.id) }.from(true).to(false)
  end
end