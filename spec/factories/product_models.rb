FactoryBot.define do
  factory :product_model do
    name {'TV'}
    weight {50}
    width {30}
    heigth {30}
    depth {30}
    sku {'TV23-SMED-XPT12-XLMR'}
    supplier {Factory.Bot.create(:supplierl)}
  end
end

