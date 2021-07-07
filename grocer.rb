require 'pry'

def find_item_by_name_in_collection(name, collection)
 counter = 0 
 while counter < collection.length 
  if name == collection[counter][:item]
    return collection[counter]
  end
 counter += 1 
 end
 nil
end

def consolidate_cart(cart)
  array = []
  counter = 0 
  while counter < cart.length
    product_hash = cart[counter]
    name = product_hash[:item]
    if find_item_by_name_in_collection(name, array)
      product_hash[:count] += 1 
    else
      array << product_hash
      product_hash[:count] = 1 
    end
  counter += 1 
  end
array
end

def apply_coupons(cart, coupons)
  
  # new_cart = []
  cart_counter = 0
  while cart_counter < cart.length
    coupon_counter = 0
    item_info = cart[cart_counter]
    while coupon_counter < coupons.length
     if item_info[:item] == coupons[coupon_counter][:item] && item_info[:count] >= coupons[coupon_counter][:num]
      #add the coupon version to the array
      add_coupons_to_cart(item_info, coupons[coupon_counter], cart)
      # else
      # # add it to the array like noraml
      # new_cart << item_info
    end
    # add_coupons_to_cart(item, coupons, cart)
    coupon_counter += 1
    end
  cart_counter +=1
  end
# new_cart
cart
end

def apply_clearance(cart)
  counter = 0 
  while counter < cart.length
    current_item = cart[counter]
    if current_item[:clearance]
      current_item[:price] = (current_item[:price] * 0.8).round(1)
    end
  counter += 1
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  counter = 0 
  running_total = 0 
  while counter < couponed_cart.length
  running_total += (final_cart[counter][:price] * final_cart[counter][:count])
  counter += 1 
  end
  if running_total > 100
    final_total = running_total * 0.9
  else
    final_total = running_total
  end
end


def add_coupons_to_cart(item, coupon, cart)
  item[:count] -= coupon[:num]
  new_item = {:item => "#{coupon[:item]} W/COUPON", :price => (coupon[:cost] / coupon[:num]), :clearance => item[:clearance], :count => coupon[:num]}
  cart << new_item
  # binding.pry
end
