FactoryBot.define do
  factory :warehouse do
    name {'Galpão da Petra'}
    code {'PTG'}
    city {'Petropolis'}
    address {'SP'}
    cep {'30293049'}
    area { 320 }
    description {'Descrição'}
  end
end
