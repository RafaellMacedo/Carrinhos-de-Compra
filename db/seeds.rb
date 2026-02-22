Product.destroy_all

Product.create!([
  {
    name: 'Samsung Galaxy S24 Ultra',
    unit_price: 12999.99,
    quantity: 10
  },
  {
    name: 'iPhone 15 Pro Max',
    unit_price: 14999.99,
    quantity: 10
  },
  {
    name: 'Xiamo Mi 27 Pro Plus Master Ultra',
    unit_price: 999.99,
    quantity: 10
  }
])

puts "Produtos do seeds criados"