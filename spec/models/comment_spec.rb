require 'rails_helper'

describe Comment do
  it { should belong_to(:user) }
  it { should belong_to(:book) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:comment) }
  it { should validate_presence_of(:user_name) }
end