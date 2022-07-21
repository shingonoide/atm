require 'rails_helper'

RSpec.describe Deposit, type: :model do
  subject { Deposit.new(account_number: 1234, amount: 1) }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without amount" do
    subject.amount=nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without account" do
    subject.account=nil
    expect(subject).to_not be_valid
  end
end
