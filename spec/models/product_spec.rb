require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with valid attributes' do
    product = Product.new(name: 'Test Product', sku: '12345', price: 9.99, stock_quantity: 10)
    expect(product).to be_valid
  end

  it 'is not valid without a name' do
    product = Product.new(name: nil)
    expect(product).not_to be_valid
  end

  it 'is not valid without a unique SKU' do
    Product.create(name: 'Test Product', sku: '12345', price: 9.99, stock_quantity: 10)
    product = Product.new(name: 'Test Product 2', sku: '12345', price: 9.99, stock_quantity: 10)
    expect(product).not_to be_valid
  end
end
