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

  describe '#available?' do
    it 'true if there is no destination' do
      stock_product = FactoryBot.create(:stock_product)

      expect(stock_product.available?).to eq true
    end
    it 'false if there is a destination' do
      stock_product = FactoryBot.create(:stock_product)
      stock_product.create_stock_product_destination!(recipient: 'Ala', address: "rua da la")

      expect(stock_product.available?).to eq false
    end
  end
end
