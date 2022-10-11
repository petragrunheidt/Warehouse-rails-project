class Order < ApplicationRecord
  enum status: { pending: 0, canceled: 1, delivered: 2 }
  validates :estimated_delivery_date, :code, presence: true
  validates :code, uniqueness: true
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  has_many :order_items
  has_many :product_models, through: :order_items

  before_validation :generate_code, on: :create

  validate :estimated_delivery_date_is_future

  private

  def generate_code
    (self.code = self.warehouse.code + SecureRandom.alphanumeric(7).upcase)
  end

  def estimated_delivery_date_is_future
    if self.estimated_delivery_date.present? and self.estimated_delivery_date <= Date.today
      self.errors.add(:estimated_delivery_date, ' deve ser futura.')
    end
  end
end
