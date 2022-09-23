class Order < ApplicationRecord
  validates :warehouse_id, :supplier_id, :user, :estimated_delivery_date, :code, presence: true
  validates :code, uniqueness: true
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8) if self.code == nil
  end
end
