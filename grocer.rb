def find_item_by_name_in_collection(name, collection)
  i=0
  while collection[i] do
  return collection[i] if collection[i][:item] == name
  i+=1
  end

  return nil
end

def consolidate_cart(cart)
 result=[]
 allitems = []

 i=0
 while cart[i] do
   allitems << cart[i][:item]
   i += 1
 end
 
 i=0
 while cart[i] do
   result << {
     :item => cart[i][:item], 
     :price => cart[i][:price], 
     :clearance => cart[i][:clearance], 
     :count => allitems.count(cart[i][:item])
   }
   i += 1
 end
 return result.uniq
 end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  pp cart
  pp coupons
  j=0 
  while coupons[j] do
    
  i=0
  while cart[i] do
    if (cart[i][:item] == coupons[j][:item]) && (cart[i][:count] >= coupons[j][:num])
      then 
      cart << 
      {
        :item => (cart[i][:item] + " W/COUPON"),
        :price => (coupons[j][:cost]/coupons[j][:num]),
        :clearance => cart[i][:clearance],
        :count => coupons[j][:num]
      }
      cart[i][:count] -= coupons[j][:num]
    end
      i += 1
    end
    j += 1
  end
    
    pp cart
    return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0 
  while cart[i] do
    cart[i][:price] = (0.8 * cart[i][:price]).round(2) if cart[i][:clearance]
    i += 1
  end
  return cart
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
  
    cart = consolidate_cart(cart)
    cart = apply_coupons(cart, coupons)
    cart = apply_clearance(cart)
    
    total = 0
    i = 0 
    
    while cart[i] do
      total += (cart[i][:price]*cart[i][:count])
      i += 1
    end 
    
    if(total > 100) 
      then 
        return (total * 0.9).round(2)
      else
        return total
    end
  
end
