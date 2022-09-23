FactoryBot.define do
  factory :product_model do
    name {'Geladeira'}
    weight { 50 }
    width { 30 }
    heigth { 30 }
    depth { 30 }
    sku { 'GL23-SMED-XPT12-XLMR '}
    supplier
  end
end

#FactoryBot.create(:product_model)
