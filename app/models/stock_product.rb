class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model

  before_validation :generate_code

  private

  def generate_code
    self.serial_number = SecureRandom.random_number(1000000000000..10000000000000).to_s
  end

end
