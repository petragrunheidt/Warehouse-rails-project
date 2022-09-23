require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'must have a code' do
      # Arrange
      order = FactoryBot.build(:order)
      # Act
      result = order.valid?
      # Assert
      expect(result).to be true
    end
    it 'must have a estimated delivery date' do
      # Arrange
      order = FactoryBot.build(:order, estimated_delivery_date: '')

      # Act
      order.valid?
      # Assert
      expect(order.errors.include? :estimated_delivery_date).to be true
    end
    it 'cant have past estimated delivery date' do
      # Arrange
      order = FactoryBot.build(:order, estimated_delivery_date: 1.day.ago)

      # Act
      order.valid?
      # Assert
      expect(order.errors.include? :estimated_delivery_date).to be true
    end
    it 'estimated delivery date cant be today' do
      # Arrange
      order = FactoryBot.build(:order, estimated_delivery_date: Date.today)

      # Act
      order.valid?
      # Assert
      expect(order.errors.include? :estimated_delivery_date).to be true
    end
    it 'estimated delivery date must be a future date' do
      # Arrange
      order = FactoryBot.build(:order, estimated_delivery_date: 1.day.from_now)

      # Act
      order.valid?
      # Assert
      expect(order.errors.include? :estimated_delivery_date).to be false
    end
  end
  describe 'generates a random code' do
    it 'when creating a new order' do
      # Arrange
      user = FactoryBot.create(:user)
      warehouse = FactoryBot.create(:warehouse)
      supplier = FactoryBot.create(:supplier)
      order = Order.new(warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2022-10-01', user: user)
      # Act
      order.save!
      result = order.code

      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end
    it 'and the code is unique' do
      # Arrange
      user = FactoryBot.create(:user)
      warehouse = FactoryBot.create(:warehouse)
      supplier = FactoryBot.create(:supplier)
      order1 = Order.create!(warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2022-10-01', user: user)
      order2 = Order.new(warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2022-10-02', user: user)
      # Act
      order2.save!
      result = order2.code

      # Assert
      expect(result).not_to eq order1.code
    end
  end
end
