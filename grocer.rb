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

def consolidate_cart(cart)
  item_count = 0
  result = {}
  final =[]

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

  result.each do |key, value|
    innerhash = value
    thing = {item: key, count: innerhash[:count], clearance: innerhash[:clearance], price: innerhash[:price]}
    final.push(thing)
  end

  final
end

def apply_coupons(cart, coupons)
  item_count = 0
  result = []
  while item_count < cart.length do
    coupon_count = 0
    item = cart[item_count][:item]
    while coupon_count < coupons.length do
      if item == coupons[coupon_count][:item] #does cart item match any coupons?
        coupon_qty = coupons[coupon_count][:num]
        if cart[item_count][:count] >= coupon_qty
          new_price = coupons[coupon_count][:cost] / coupon_qty
          result.push({item: "#{item} W/COUPON", price: new_price, clearance: cart[item_count][:clearance], count: 0})
          while cart[item_count][:count] >= coupon_qty do #does qty match requirments?
            result[-1][:count] += coupon_qty
            cart[item_count][:count] -= coupon_qty
          end
        end


      end #if coupon match name end statement

       coupon_count += 1
    end

#extra - if we want to remove entire hash when itemcount = 0
  #  if cart[item_count][:count] > 0
  #    result.push(cart[item_count]) #push remaining qtys into results
  #    cart.delete_at(item_count)
  #  end

  #  if cart[item_count][:count] == 0
  #    cart.delete_at(item_count)
  #  end

    item_count += 1
  end
  result + cart
end

 def apply_clearance(cart)
  i = 0
  while i < cart.length do
    if cart[i][:clearance] == true
      cart[i][:price] *= 0.8
      cart[i][:price].round(2)
    end
    i += 1
  end
  cart
end


def checkout(cart, coupons)
  total = 0
  consolidate_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidate_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)


  i = 0
  while i < applied_clearance.length do
    total += applied_clearance[i][:price] * applied_clearance[i][:count]
    i += 1
  end

  if total > 100
    total *= 0.90
  end

  total.round(2)


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
