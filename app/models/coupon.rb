class Coupon < ActiveRecord::Base
  def self.search(search)
    if search
      @coupon = find_by(number: search.to_i)
      if @coupon 
        @cart = Cart.find(session[:cart_id])
        @cart.discount += @coupon.discount
        @cart.discount.save
        @coupon.destroy
        puts @cart.discount
      end
    end
  end
end
