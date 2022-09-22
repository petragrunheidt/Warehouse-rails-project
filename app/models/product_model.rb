class ProductModel < ApplicationRecord
  validates :name, :weigth, :heigth, :width, :depth,
  :sku, :supplier, presence: true
  validates :weigth, :heigth, :width, :depth, comparison: { greater_than: 0 }
  validates :sku, length: { is: 20 }
  validates :sku, uniqueness: true
  belongs_to :supplier
end
