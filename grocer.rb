def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    if collection[i][:item] == name
      return true 
    end 
      i += 1
  end
  nil
end

def consolidate_cart(cart)
new_cart = []
  i = 0 
  while i < cart.length do 
      new_cart_item = find_item_by_name_in_collection
      if new_cart_item
          new_cart_item += 1 
      else 
        new_cart_item = {
          :item => cart[i][:item], 
          :price => cart[i][:price], 
          :clearence => cart[i][:clearence], 
          :count => 1
        }
      end
    i += 1 
  end 
return new_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
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
end
