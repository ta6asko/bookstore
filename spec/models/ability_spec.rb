require 'rails_helper'
require "cancan/matchers"

describe User do

  let(:user) { create(:user) }
  let(:order) { create(:order) }
  subject(:ability) { Ability.new(user) }

  context "can" do
    it { expect(ability).to be_able_to :index, build(:book) }
    it { expect(ability).to be_able_to :show, build(:book) }
    it { expect(ability).to be_able_to :index, build(:category) }
    it { expect(ability).to be_able_to :show, build(:category) }
    it { expect(ability).to be_able_to :edit, build(:billing_address, user_id: user.id) }
    it { expect(ability).to be_able_to :update, build(:billing_address, user_id: user.id) }
    it { expect(ability).to be_able_to :edit, build(:shipping_address, user_id: user.id) }
    it { expect(ability).to be_able_to :update, build(:shipping_address, user_id: user.id) }
    it { expect(ability).to be_able_to :edit, build(:payment, user_id: user.id) }
    it { expect(ability).to be_able_to :update, build(:payment, user_id: user.id) }
    it { expect(ability).to be_able_to :edit, build(:delivery) }
    it { expect(ability).to be_able_to :create, build(:line_item) }
    it { expect(ability).to be_able_to :update, build(:line_item) }
    it { expect(ability).to be_able_to :destroy, build(:line_item) }
    it { expect(ability).to be_able_to :index, build(:order) }
    it { expect(ability).to be_able_to :show, build(:order, user_id: user.id) }
    it { expect(ability).to be_able_to :update, build(:order) }
    it { expect(ability).to be_able_to :empty_cart, build(:order) }
    it { expect(ability).to be_able_to :cart, build(:order) }
    it { expect(ability).to be_able_to :confirm, build(:order, user_id: user.id) }
    it { expect(ability).to be_able_to :complete, build(:order, user_id: user.id) }
    it { expect(ability).to be_able_to :check_coupon, build(:order, user_id: user.id) }
    it { expect(ability).to be_able_to :index, build(:comment) }
    it { expect(ability).to be_able_to :new, build(:comment) }
    it { expect(ability).to be_able_to :create, build(:comment) }
    it { expect(ability).to be_able_to :settings_update_billing_address, user }
    it { expect(ability).to be_able_to :settings_update_shipping_address, user }
    it { expect(ability).to be_able_to :update_email, user }
    it { expect(ability).to be_able_to :update_password, user }
    it { expect(ability).to be_able_to :destroy_user, user }
    it { expect(ability).to be_able_to :edit, user }
  end

  context "cannot" do
    it { expect(ability).not_to be_able_to :edit, build(:billing_address) }
    it { expect(ability).not_to be_able_to :update, build(:billing_address) }
    it { expect(ability).not_to be_able_to :edit, build(:shipping_address) }
    it { expect(ability).not_to be_able_to :update, build(:shipping_address) }
    it { expect(ability).not_to be_able_to :edit, build(:payment) }
    it { expect(ability).not_to be_able_to :update, build(:payment) }
    it { expect(ability).not_to be_able_to :show, build(:order) }
    it { expect(ability).not_to be_able_to :edit, build(:user) }
    it { expect(ability).not_to be_able_to :settings_update_billing_address, build(:user) }
    it { expect(ability).not_to be_able_to :settings_update_shipping_address, build(:user) }
    it { expect(ability).not_to be_able_to :update_email, build(:user) }
    it { expect(ability).not_to be_able_to :update_password, build(:user) }
    it { expect(ability).not_to be_able_to :destroy_user, build(:user) }
  end
end