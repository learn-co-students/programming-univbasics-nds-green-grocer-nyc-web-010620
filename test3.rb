def find_item_by_name_in_collection(name, collection)
  item_count = 0
  while item_count < collection.length do
    if name == collection[item_count][:item]
      result = collection[item_count]
    end
    item_count += 1
  end
  result
end

items = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true},
  {:item => "KALE", :price => 3.00, :clearance => false},
  {:item => "BLACK_BEANS", :price => 2.50, :clearance => false},
  {:item => "ALMONDS", :price => 9.00, :clearance => false},
  {:item => "TEMPEH", :price => 3.00, :clearance => true},
  {:item => "CHEESE", :price => 6.50, :clearance => false},
  {:item => "BEER", :price => 13.00, :clearance => false},
  {:item => "PEANUTBUTTER", :price => 3.00, :clearance => true},
  {:item => "BEETS", :price => 2.50, :clearance => false},
  {:item => "SOY MILK", :price => 4.50, :clearance => true}
]


cart = [find_item_by_name_in_collection('TEMPEH', items), find_item_by_name_in_collection('PEANUTBUTTER', items), find_item_by_name_in_collection('ALMONDS', items)]

def consolidate_cart(cart)
  item_count = 0
  result = {}
  final = []

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

  result.each { |key, value| # convert hash to array 
    #instructions were wrong, result should be array, not hash
    innerhash = value
    thing = {item: key, count: innerhash[:count], clearance: innerhash[:clearance], price: innerhash[:price]}
    final.push(thing)
  }

  final

end



puts consolidate_cart(cart)
