class ShippingAddress < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :country

  validates_presence_of :first_name, :last_name, :street_address, :city, :on => :update
  validates :phone, numericality: { equal_to: 12, allow_nil: true }
  validates :zip, numericality: { equal_to: 5, allow_nil: true }
  
  # validates :first_name, :last_name, :street_address, :city, :country_id, :zip, :phone, presence: true
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

end
