def consolidate_cart(cart)
  item_count = 0
  result = {}

  while item_count < cart.length do
    item = cart[item_count][:item]
    result[item] = {count: 0}
    item_count += 1
  end

  item_count = 0
  while item_count < cart.length do
    item = cart[item_count][:item]
    result[item][:count] += 1
    result[item][:clearance] = cart[item_count][:clearance]
    result[item][:price] = cart[item_count][:price]
    item_count += 1
  end

  result

end


test = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true },
  {:item => "KALE", :price => 3.00, :clearance => false}
]

puts consolidate_cart(test)
