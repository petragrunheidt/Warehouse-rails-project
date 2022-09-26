FactoryBot.define do
  factory :warehouse do
    name {'Galpão da Petra'}
    code {(0...3).map { (65 + rand(26)).chr }.join}
    city {'Petropolis'}
    address {'SP'}
    cep {'30293049'}
    area { 320 }
    description {'Descrição'}
  end
end
