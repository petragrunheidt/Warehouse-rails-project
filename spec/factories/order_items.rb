FactoryBot.define do
  factory :order_item do
    product_model
    order
    quantity { 10 }
  end
end
