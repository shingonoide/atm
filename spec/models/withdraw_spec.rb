require 'rails_helper'

RSpec.describe Withdraw, type: :model do
  fixtures :accounts
  subject { a=accounts(:account1); Withdraw.new(account: a, amount: 1) }
  
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
