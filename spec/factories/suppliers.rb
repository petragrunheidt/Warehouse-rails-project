FactoryBot.define do
  factory :supplier do
    corporate_name {'PETR ltda.'}
    brand_name {'Petra'}
    city {'Petropolis'}
    state {'SP'}
    email {'petramail@gmail'}
    address {'Rua da Petra'}
    registration_number {SecureRandom.random_number(1000000000000..10000000000000).to_s}
  end
end




