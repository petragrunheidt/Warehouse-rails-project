require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'must have a code' do
      # Arrange
      user = FactoryBot.create(:user)
      warehouse = FactoryBot.create(:warehouse)
      supplier = FactoryBot.create(:supplier)
      order = Order.new(warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2022-10-01', user: user)

      # Act
      result = order.valid?
      # Assert
      expect(result).to be true
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
