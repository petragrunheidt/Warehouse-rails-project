class Supplier < ApplicationRecord
    validates :corporate_name, :brand_name, :registration_number,
     :city, :state, :email, :address, presence: true
    validates :registration_number, uniqueness: true
    validates :registration_number, length: { is: 13 }
    validates :registration_number, numericality: { only_integer: true}
    has_many :product_models

    def full_description
        "#{corporate_name} - #{brand_name} | CNPJ:#{registration_number.insert(2, '.').insert(6, '.').insert(10, '/').insert(15, '-')}"
    end
end
