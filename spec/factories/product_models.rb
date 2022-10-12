FactoryBot.define do
  factory :product_model do
    name {'Geladeira'}
    weight { 50 }
    width { 30 }
    heigth { 30 }
    depth { 30 }
    sku { SecureRandom.alphanumeric(20)}
    supplier
  end
end

