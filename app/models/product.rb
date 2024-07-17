class Product < ApplicationRecord
	validates :name, presence: true
	validates :sku, presence: true, uniqueness: true
	validates :price, presence: true
	validates :stock_quantity, presence: true
end
