require 'rails_helper'

describe Book do
  it { should have_and_belong_to_many(:authors) }
  it { should have_many(:line_items) }
  it { should have_many(:comments) }
  it { should belong_to(:category) }
  it { should validate_uniqueness_of(:title) }
  it { should validate_numericality_of(:price) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:full_description) }
end