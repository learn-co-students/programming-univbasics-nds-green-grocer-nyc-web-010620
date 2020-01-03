def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  collection.each{ |element|
    if element[:item] == name
      return element
    end
  }
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  result = []
  cart.each { |element|
    if find_item_by_name_in_collection(element[:item], result)
      find_item_by_name_in_collection(element[:item], result)[:count] += 1
    else
      result << {
        :item => element[:item],
        :price => element[:price],
        :clearance => element[:clearance],
        :count => 1
      }
    end
  }
  return result
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  coupons.each{ |coupon|
    element = coupon[:item]
    item = find_item_by_name_in_collection(element, cart)
    discount = find_item_by_name_in_collection(element + "W/COUPON", cart)
    
    if item[:count] >= coupon[:num] && item
      if discount
        item[:count] -= coupon[:num]
        discount[:count] += coupon[:num]
      end
    elsif item
      cart << {
        :item => coupon[:item] + "W/COUPON",
        :price => coupon[:cost]/coupon[:num]
        :clearance => item[:clearance]
        :count => coupon[:num]
      }
    end
  }
  
  return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each{ |item|
    if item[:clearance]
      item[:price] *= 0.8
    end
  }
  return cart
end

def checkout(cart, coupons)
  unique_items = consolidate_cart(cart)
  discount = apply_coupons(unique_items, coupons)
  final = apply_clearance(discount)
  
  final_price = 0
  
  final.each{|element|
    final_price += (element[:price] * element[:count])
  }
  
  if final_price > 100
    return final_price * 0.9
  end
  return final_price
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
end
