require 'rails_helper'

describe Payment do
  let(:payment) { create(:payment) }

  it { should belong_to(:user) }
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
  it "validate_numericality_of number on update" do
    payment.number = 'asd'
    payment.save
    expect(payment).not_to be_valid
  end
  it "validate_numericality_of card_code on update" do
    payment.card_code = 'asd'
    payment.save
    expect(payment).not_to be_valid
  end
    it "validate_numericality_of number on update" do
    payment.number = 123456789123456
    payment.save
    expect(payment).not_to be_valid
  end
  it "validate_numericality_of card_code on update" do
    payment.card_code = 12
    payment.save
    expect(payment).not_to be_valid
  end
end
