require 'rails_helper'

describe Category do

  it { should have_many(:books) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

end