def find_item_by_name_in_collection(name, collection)
 index= 0
while index<collection.length do
 if collection[index][:item][name] 
   return collection[index]
 end
 index+=1
 end
 nil
end

def consolidate_cart(cart)
c_cart = []
index = 0
while index<cart.length do
  new_cart_item = find_item_by_name_in_collection(cart[index][:item], c_cart)
  if new_cart_item
  new_cart_item[:count] +=1
  else 
  new_item = {
    :item => cart[index][:item],
    :price => cart[index][:price],
    :clearance => cart[index][:clearance],
    :count => 1
  }
  c_cart << new_item
  end
  index+=1
end
c_cart
end

def apply_coupons(cart, coupons)
i = 0
while i<coupons.length do
discounted_item = find_item_by_name_in_collection(coupons[i][:item], cart)
coupon_item_name = "#{discounted_item[:item]} W/COUPON"
cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)
discounted_cost = coupons[i][:cost]/coupons[i][:num]

if discounted_item && (discounted_item[:count] >= coupons[i][:num])
  if cart_item_with_coupon
    cart_item_with_coupon[:count] += coupons[i][:num]
    discounted_item[:count] -= coupons[i][:num]
    else
    coupon_item = {
    :item => coupon_item_name,
    :price => discounted_cost,
    :clearance => discounted_item[:clearance],
    :count => coupons[i][:num]
    }
    cart << coupon_item
    discounted_item[:count] -= coupons[i][:num]
  end
end
i+=1
end
cart
end

def apply_clearance(cart)
  i =0
  while i<cart.length do
  if cart[i][:clearance]
  discount = cart[i][:price]*0.2
  cart[i][:price] -= discount.round(2)
  end
  i+=1
  end
  cart
end

def checkout(cart, coupons)
sorted_cart = consolidate_cart(cart)
coupon_cart = apply_coupons(sorted_cart, coupons)
final_cart = apply_clearance(coupon_cart)
total = 0
i=0
while i<final_cart.length do
total += (final_cart[i][:price]*final_cart[i][:count])
i+=1
end
if total > 100
total -= (total*0.1)
end
total
end
