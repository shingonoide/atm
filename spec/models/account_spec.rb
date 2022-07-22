
require 'rails_helper'

RSpec.describe Account do
  fixtures :accounts
  subject { Account.first }

  describe "#balance" do
    it { expect(subject.balance).to eql 0 }
    it { expect { subject.sub_funds('11.0'.to_d) }.to raise_error(Account::AccountError) }
    it { expect { subject.sub_funds('-1.0'.to_d) }.to raise_error(Account::AccountError) }
    it { expect { subject.plus_funds('-1.0'.to_d) }.to raise_error(Account::AccountError) }
    it { expect { subject.sub_funds('0'.to_d) }.to raise_error(Account::AccountError) }
    it { expect { subject.plus_funds('0'.to_d) }.to raise_error(Account::AccountError) }
  
    it { expect(subject.plus_funds('1.0'.to_d).balance).to eql '1.0'.to_d }
    it do
      expect do
        subject.plus_funds('1.1'.to_d)
        subject.sub_funds('1.0'.to_d)
      end.to(change {subject.balance})
    end 
  end

  describe 'double operation' do
    let(:strike_volume) { '10.0'.to_d }

    it 'expect double operation funds' do
      expect do
        subject.plus_funds(strike_volume)
        subject.sub_funds(strike_volume)
      end.to_not(change { subject.balance })
    end
  end

  describe "closes account" do
    it "should soft delete the account" do
      expect{subject.destroy}.to change { Account.only_deleted.count }
    end
  end

end
