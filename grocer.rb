def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0
  while index < collection.length do
    if name == collection[index][:item]
      return collection[index]
    else
      nil
    end
    index += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  index = 0
  item_desc_count = []

  while index < cart.length do
    item_name = cart[index][:item]
    item_desc = find_item_by_name_in_collection(item_name, item_desc_count) #returns a hash from info provided

    if item_desc #if the provided info already exists, inc 1, if not set to 1
      item_desc[:count] += 1
    else
      cart[index][:count] = 1
      item_desc_count << cart[index]
    end
    index += 1
  end
  item_desc_count
end

def format_coupon(coupon)
  {
    :item => "#{coupon[:item]} W/COUPON",
    :price => (coupon[:cost] / coupon[:num]),
    :count => coupon[:num]
  }
end

def format_coupon_cart(item, coupon, cart)
  item[:count] -= coupon[:num]
  formatted_coupon = format_coupon(coupon)
  formatted_coupon[:clearance] = item[:clearance]

  cart << formatted_coupon
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while index < coupons.length do
    coupon = coupons[index]
    item_has_coupon = find_item_by_name_in_collection(coupon[:item], cart)
    enough_items_coupon = item_has_coupon[:count] >= coupon[:num]

    if item_has_coupon && enough_items_coupon
      format_coupon_cart(item_has_coupon, coupon, cart)
    end
    index += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while index < cart.length do
    clearance_rate = 0.2
    if cart[index][:clearance]
      cart[index][:price] = ((1 - clearance_rate) * cart[index][:price]).round(2)
    end
  index += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  total = 0
  index = 0
  total_sale = 0.1
  consolidated_cart = consolidate_cart(cart)
  apply_coupons(consolidated_cart, coupons) #mutates cart
  apply_clearance(consolidated_cart) #mutates cart

  while index < consolidated_cart.length do
    total += consolidated_cart[index][:count] * consolidated_cart[index][:price]
    index += 1
  end
  if total >= 100
    total = total * (1 - total_sale)
  end
  total
end
