FactoryBot.define do
  factory :stock_product do
    warehouse
    order
    product_model
    serial_number { SecureRandom.random_number(1000000000000..10000000000000).to_s }
  end
end
