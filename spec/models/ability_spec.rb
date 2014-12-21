require 'spec_helper'
require "cancan/matchers"

describe  do

  let(:user) { create(:user) }
  let(:order) { create(:order) }
  subject(:ability) { Ability.new(user) }

  it { should be_able_to :edit, build(:billing_address) }
  it { should be_able_to :update, build(:billing_address) }
  it { should be_able_to :edit, build(:shipping_address) }
  it { should be_able_to :update, build(:shipping_address) }
  it { should be_able_to :edit, build(:payment) }
  it { should be_able_to :update, build(:payment) }
  it { should be_able_to :index, build(:book) }
  it { should be_able_to :show, build(:book) }
  it { should be_able_to :index, build(:category) }
  it { should be_able_to :show, build(:category) }
  it { should be_able_to :edit, build(:delivery) }
  it { should be_able_to :create, build(:line_item) }
  it { should be_able_to :destroy, build(:line_item) }
  it { should be_able_to :index, build(:order) }
  it { should be_able_to :show, build(:order) }
  it { should be_able_to :update, build(:order) }
  it { should be_able_to :empty_cart, build(:order) }
  it { should be_able_to :cart, build(:order) }
  it { should be_able_to :confirm, build(:order, user_id: user.id) }
  it { should be_able_to :complete, build(:order, user_id: user.id) }
  it { should be_able_to :check_coupon, build(:order, user_id: user.id) }
  it { should be_able_to :index, build(:comment) }
  it { should be_able_to :new, build(:comment) }
  it { should be_able_to :create, build(:comment) }
  it { should be_able_to :settings_update_billing_address, build(:user) }
  it { should be_able_to :settings_update_shipping_address, build(:user) }
  it { should be_able_to :update_email, build(:user) }
  it { should be_able_to :update_password, build(:user) }
  it { should be_able_to :destroy_user, build(:user) }
  it { should be_able_to :edit, build(:user) }
end