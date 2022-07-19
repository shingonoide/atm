
# encoding: UTF-8
# frozen_string_literal: true
require('rails_helper')

describe Account do
  subject { Account.create(account_number: 1234, password: '123456') }

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
    let(:account) { Account.create(account_number: 1234, password: '123456') }

    it 'expect double operation funds' do
      expect do
        account.plus_funds(strike_volume)
        account.sub_funds(strike_volume)
      end.to_not(change { account.balance })
    end
  end

end
