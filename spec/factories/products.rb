FactoryBot.define do
  factory :product do
    name { 'Product1' }
    sku { '12345' }
    price { 13 }
    stock_quantity { 10 }
  end
end
