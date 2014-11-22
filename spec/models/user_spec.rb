require 'rails_helper'

describe User do
  it { should have_many(:orders) }
  it { should have_many(:comments) }
  it { should have_one(:billing_address) }
  it { should have_one(:shipping_address) }
end