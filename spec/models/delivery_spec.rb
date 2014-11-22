require 'rails_helper'

describe Delivery do

  it { should have_many(:orders) }
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:price) }
  it { should validate_uniqueness_of(:name) }

end