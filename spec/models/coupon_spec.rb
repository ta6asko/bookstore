require 'rails_helper'

describe Coupon do

  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:discount) }
  it { should validate_uniqueness_of(:number) }

end