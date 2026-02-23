class AbandonedCartsJob < ApplicationJob
  queue_as :default

  def perform
    Cart.active.where("last_interaction_at <= ?", 3.hours.ago).find_each do |cart|
      cart.update!(abandoned: true)
    end

    Cart.abandoned.where("last_interaction_at <= ?", 7.days.ago).find_each do |cart|
      cart.destroy!
    end
  end
end