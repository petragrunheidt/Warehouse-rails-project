class Warehouse < ApplicationRecord
    validates :name, :code, :city, :area, :address, :cep, :description, presence: true
    validates :code, uniqueness: true
    validates :code, length: { is: 3}
    validates :cep, length: { is: 8}
    validates :cep, numericality: { only_integer: true}
    has_many :stock_products

    def full_description
        "#{code} | #{name}"
    end
end
