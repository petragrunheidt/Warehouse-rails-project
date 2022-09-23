class Order < ApplicationRecord
  validates :warehouse_id, :supplier_id, :user, :estimated_delivery_date, presence: true
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
end
