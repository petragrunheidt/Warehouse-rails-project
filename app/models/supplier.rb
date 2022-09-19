class Supplier < ApplicationRecord
    validates :corporate_name, :brand_name, :registration_number,
     :city, :state, :email, :address, presence: true
    validates :registration_number, length: { is: 13 }
end
