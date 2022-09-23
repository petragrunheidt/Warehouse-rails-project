FactoryBot.define do
  factory :order do
    user
    warehouse
    supplier
    estimated_delivery_date {1.week.from_now}
  end
end

