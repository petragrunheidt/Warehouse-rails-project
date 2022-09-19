require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
    it 'false when name is empty' do
        # Arrange
        sup = Supplier.create!(brand_name: 'Petra', corporate_name: 'PETR', registration_number: 29304,
          city: 'Petropolis', state: 'SP', email: 'petramail')
        product_model = ProductModel.new(weigth: 50, width: 50, heigth: 50,
          depth: 50, sku: 'TV23-SMED-XPT12', supplier: sup)

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
    end
    it 'false when sku is empty' do
        # Arrange
        sup = Supplier.create!(brand_name: 'Petra', corporate_name: 'PETR', registration_number: 29304,
          city: 'Petropolis', state: 'SP', email: 'petramail')
        product_model = ProductModel.new(name: 'Bolo', weigth: 50, width: 50, heigth: 50,
          depth: 50, supplier: sup)

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
    end
    it 'false when weigth is empty' do
        # Arrange
        sup = Supplier.create!(brand_name: 'Petra', corporate_name: 'PETR', registration_number: 29304,
          city: 'Petropolis', state: 'SP', email: 'petramail')
        product_model = ProductModel.new(name: 'Bolo', width: 50, heigth: 50,
          depth: 50, sku: 'TV23-SMED-XPT12', supplier: sup)

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
    end
    it 'false when supplier is empty' do
        # Arrange
        product_model = ProductModel.new(name: 'Bolo', weigth: 50, width: 50, heigth: 50,
          depth: 50, sku: 'TV23-SMED-XPT12')

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
    end
  end
end
end

