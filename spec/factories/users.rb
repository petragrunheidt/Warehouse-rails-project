FactoryBot.define do
  factory :user do
    name {'factorytestuser'}
    email {SecureRandom.alphanumeric(12).to_s + 'mail@email.com'}
    password {'password'}
  end
end
