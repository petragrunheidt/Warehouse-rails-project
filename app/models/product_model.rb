class ProductModel < ApplicationRecord
  validates :name, :weigth, :heigth, :width, :depth, 
  :sku, :supplier, presence: true
  belongs_to :supplier
end
