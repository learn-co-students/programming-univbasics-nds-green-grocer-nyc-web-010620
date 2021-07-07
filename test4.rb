test1 = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "CHEESE", :price => 6.50, :clearance => false, :count => 4},
]

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

puts apply_clearance(test1)
