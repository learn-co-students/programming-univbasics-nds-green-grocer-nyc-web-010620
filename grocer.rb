def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0 
    while index < collection.count do 
      if collection[index][:item] == name 
        return collection[index]
      end
      index += 1 
    end 
      nil 
    
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []
  index = 0 
    while index < cart.count do 
      item_name = cart[index][:item]
      item_searching_for = find_item_by_name_in_collection(item_name, new_cart)
      
      if item_searching_for
        item_searching_for[:count] += 1 
      else 
        cart[index][:count] = 1 
        new_cart << cart[index]
      end 
        index += 1 
    end 
    new_cart
end

def make_coupon_hash(coupon)
  { 
    :item => "#{coupon[:item]} W/COUPON",
    :price => coupon[:cost] / coupon[:num],
    :count => coupon[:num]
  }
end 
def applying_coupons_to_item(matching_item, coupon, cart)
  matching_item[:count] -= coupon[:num]
  new_item_with_coupon = make_coupon_hash(coupon)
  new_item_with_coupon[:clearance] = matching_item[:clearance]
  cart << new_item_with_coupon
end 

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0 
  
  while index < coupons.count do 
    coupon = coupons[index]
    item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
    item_in_cart = !!item_with_coupon
    correct_quantity = item_in_cart && item_with_coupon[:count] >= coupon[:num]
    if item_in_cart && correct_quantity
      applying_coupons_to_item(item_with_coupon, coupon, cart)
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
  
  while index < cart.count do 
    item = cart[index]
    if item[:clearance]
      discounted_price = (item[:price] * 0.8).round(2)
      item[:price] = discounted_price
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
  final_price = 0 
  index = 0 
  
  new_cart = consolidate_cart(cart)
  new_cart_with_coupons = apply_coupons(new_cart, coupons)
  final_cart = apply_clearance(new_cart_with_coupons)
  
  while index < final_cart.count do 
    item_cost = final_cart[index][:price] * final_cart[index][:count]
    final_price += item_cost
    index += 1 
  end 
  
  if final_price >= 100 
    final_price * 0.9
  else 
    final_price
  end 
    
end
