require 'rails_helper'

describe Order do
  it { should belong_to(:delivery) }
  it { should belong_to(:user) }
  it { should have_many(:line_items).dependent(:destroy) }
  it { should have_one(:payment) }

end