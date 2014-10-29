class BillingAddress < ActiveRecord::Base
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

end
