class BillingAddress < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  
  validates_presence_of :on => :update
  # validates :first_name, :last_name, :street_address, :city, :country_id, :zip, :phone, presence: true
  # validate :update_validation, :on => :update

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

end
