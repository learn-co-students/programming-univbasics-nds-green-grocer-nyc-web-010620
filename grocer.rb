
def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length 
    if collection[i][:item] == name 
      return collection[i]
    end 
  i += 1 
end 

end

def consolidate_cart(cart)
  new_cart = [] 
  
  counter = 0 
  while counter < cart.length 
    new_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
    if new_item != nil
      new_item[:count] += 1
    else 
      new_item = {
        :item => cart[counter][:item],
        :price => cart[counter][:price],
        :clearance => cart[counter][:clearance],
        :count => 1
      }
      new_cart << new_item 
    end 
  counter += 1 
end 

return new_cart 
end

def apply_coupons(cart, coupons)
  i = 0 
  while i < coupons.length 
  cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
  couponed_item_name = "#{coupons[i][:item]} W/COUPON"
  cart_item_name_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
  
    if cart_item && cart_item[:count] >= coupons[i][:num]
      if cart_item_name_with_coupon
        cart_item_name_with_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      else 
      cart_item_name_with_coupon = {
        :item => couponed_item_name,
        :price => coupons[i][:cost] / coupons[i][:num],
        :count => coupons[i][:num],
        :clearance => cart_item[:clearance]
        
      }
      cart << cart_item_name_with_coupon
      cart_item[:count] -= coupons[i][:num]
    end 
  end 
  i += 1 
end 
cart 
 
end

#cart = [
#   {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
#   {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
# ]

# coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.00}]

# new_cart [
#   {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 1},
#   {:item => "KALE", :price => 3.00, :clearance => false, :count => 1},
#   {:item => "AVOCADO W/COUPON", :price => 2.50, :clearance => true, :count => 2}
# ]




def apply_clearance(cart)
  i = 0 
  while i < cart.length do 
    cart_item = cart[i]
    
    if cart_item[:clearance] 
      cart_item[:price] = (cart_item[:price] * 0.80).round(2)
    end 
    i += 1 
  end 
  return cart 
end

# [
#   {:item => "PEANUT BUTTER", :price => 3.00, :clearance => true,  :count => 2},
#   {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
#   {:item => "SOY MILK", :price => 4.50, :clearance => true,  :count => 1}
# ]
# it should update the cart with clearance applied to PEANUT BUTTER and SOY MILK:

# [
#   {:item => "PEANUT BUTTER", :price => 2.40, :clearance => true,  :count => 2},
#   {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
#   {:item => "SOY MILK", :price => 3.60, :clearance => true,  :count => 1}
# ]
# The Float class' built-in round method will be helpful here to make sure your values align. 2.4900923090909029304 becomes 2.5 if we use it like so: 2.4900923090909029304.round(2)

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  shopping_list = apply_clearance(couponed_cart)   # array 
  total = 0
  
  i = 0
  while i < shopping_list.length 
    total += shopping_list[i][:price] * shopping_list[i][:count]
  i += 1 
end 
  if total > 100
    total -= (total * 0.10)
  end 
  return total
  
  
  
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
