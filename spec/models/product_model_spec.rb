require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
    it 'false when name is empty' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
          city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        product_model = ProductModel.new(weigth: 50, width: 50, heigth: 50,
          depth: 50, sku: 'TV23-SMED-XPT12-KMT7', supplier: sup)

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
    end
    it 'false when sku is empty' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
          city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        product_model = ProductModel.new(name: 'Bolo', weigth: 50, width: 50, heigth: 50,
          depth: 50, supplier: sup)

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
    end
    it 'false when weigth is empty' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
          city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        product_model = ProductModel.new(name: 'Bolo', width: 50, heigth: 50,
          depth: 50, sku: 'TV23-SMED-XPT12-KMT7', supplier: sup)

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
    end
    it 'false when supplier is empty' do
        # Arrange
        product_model = ProductModel.new(name: 'Bolo', weigth: 50, width: 50, heigth: 50,
          depth: 50, sku: 'TV23-SMED-XPT12-KMT7')

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
    end
  end
    context 'length' do
      it 'false when SKU length is greater than 20' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
          city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        product_model = ProductModel.new(name: 'Bolo', weigth: 50, width: 50, heigth: 50,
          depth: 50, sku: 'TV23-SMED-XPT12-KMT7KMND', supplier: sup)

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
      end
      it 'false when SKU length is lower than 20' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
          city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        product_model = ProductModel.new(name: 'Bolo', weigth: 50, width: 50, heigth: 50,
          depth: 50, sku: 'TV23-SMED-XPT12', supplier: sup)

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
      end
    end
    context 'uniqueness' do
      it 'false when registering duplicated SKU' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
          city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        ProductModel.create!(name: 'TV', weigth: 30, width: 30, heigth: 30,
          depth: 30, sku: 'TV23-SMED-XPT12-KMT7', supplier: sup)
        product_model2 = ProductModel.new(name: 'Bolo', weigth: 50, width: 50, heigth: 50,
          depth: 50, sku: 'TV23-SMED-XPT12-KMT7', supplier: sup)

        # Act
        result = product_model2.valid?
        # Assert
        expect(result).to eq false
      end
    end
    context 'comparison' do
      it 'false when weigth is negative' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
          city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        product_model = ProductModel.new(name: 'Bolo', weigth: -50, width: 50, heigth: 50,
          depth: 50, sku: 'TV23-SMED-XPT12', supplier: sup)

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
      end
      it 'false when heigth is zero' do
        # Arrange
        sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
          city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
        product_model = ProductModel.new(name: 'Bolo', weigth: 50, width: 50, heigth: 0,
          depth: 50, sku: 'TV23-SMED-XPT12', supplier: sup)

        # Act
        result = product_model.valid?
        # Assert
        expect(result).to eq false
      end
    end
  end
end

