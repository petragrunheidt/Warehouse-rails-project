require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'generates serial number' do
    it 'when creating StockProduct' do
      # Arrange
      stock_product = FactoryBot.create(:stock_product)
      # Act
      result = stock_product.serial_number
      # Assert
      expect(result.length).to eq 20
    end
    it "and isn't modified" do
        # Arrange
        order = FactoryBot.create(:order)
        stock_product = FactoryBot.create(:stock_product)
        # Act
        original_serial_number = stock_product.serial_number
        stock_product.order = order
        result = stock_product.serial_number
        # Assert
        expect(result).to eq original_serial_number
    end
  end
end
