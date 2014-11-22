require 'rails_helper'

describe Payment do
  let(:payment) { create(:payment) }

  it { should belong_to(:order) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:card_code) }
  it { should validate_presence_of(:expiration_date) }
  it { should validate_numericality_of(:number).is_equal_to(16) }
  it { should validate_numericality_of(:card_code).is_equal_to(3) }

  it "validates_presence_of number on update" do
    payment.number = nil
    payment.save
    expect(payment).not_to be_valid
  end
  it "validates_presence_of expiration_date on update" do
    payment.expiration_date = nil
    payment.save
    expect(payment).not_to be_valid
  end
  it "validates_presence_of card_code on update" do
    payment.card_code = nil
    payment.save
    expect(payment).not_to be_valid
  end
end
