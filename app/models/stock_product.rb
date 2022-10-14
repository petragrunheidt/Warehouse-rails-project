class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model
  has_one :stock_product_destination

  before_validation :generate_code, on: :create

  def available?
    self.stock_product_destination.nil?
  end

  private

  def generate_code
    self.serial_number = SecureRandom.random_number(10**19..10**20).to_s
  end

end
