require 'rails_helper'

describe Country do
  it { should have_many(:billing_addresses) }
  it { should have_many(:shipping_addresses) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end