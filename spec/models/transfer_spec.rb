require 'rails_helper'

RSpec.describe Transfer, type: :model do
  fixtures :accounts
  subject { Transfer.new(account: accounts(:account_with_balance), amount: 50) }
 
  describe "accounts" do
    it 'should have amount and to_account_number' do
      subject.amount = 10
      subject.to_account_number = accounts(:account2).account_number
      expect(subject).to be_valid
    end

    it 'should define amount and to_account_number' do
      expect(subject).to_not be_valid
    end

    it 'should not tranfer to same account number' do
      subject.amount = 10
      subject.to_account_number = accounts(:account_with_balance).account_number
      expect(subject).to_not be_valid
    end

    it 'should change main account balance' do
      subject.to_account_number = accounts(:account2).account_number

      expect do
        # only working when call save more than one time
        subject.save 
        subject.save
      end.to change { subject.account.balance }
    end
  end

  context "#amount" do
    it do
      subject.to_account_number = accounts(:account2)
      expect(subject).to be_valid
    end
 
    it 'should define amount' do
      subject.amount = nil
      expect(subject).to_not be_valid 
    end
    
  end

  describe "#fee" do

    let(:testcases) { 
      [
        { time: Time.parse('2022-07-26 13:15:30 -0300'), fee: 5 }, # tuesday at noon
        { time: Time.parse('2022-07-26 20:15:30 -0300'), fee: 7 }, # tuesday at night
        { time: Time.parse('2022-07-27 12:14:33 -0300'), fee: 5 }, # wednesday at noon
        { time: Time.parse('2022-07-27 19:14:33 -0300'), fee: 7 }, # wednesday at night
        { time: Time.parse('2022-07-30 13:14:33 -0300'), fee: 7 }, # sartuday
        { time: Time.parse('2022-07-31 09:00:00 -0300'), fee: 7 }, # sunday
      ]
     }

    let(:testcases_above_1000) { 
      [
        { time: Time.parse('2022-07-26 13:15:30 -0300'), fee: 15 }, # tuesday at noon
        { time: Time.parse('2022-07-26 20:15:30 -0300'), fee: 17 }, # tuesday at night
        { time: Time.parse('2022-07-27 12:14:33 -0300'), fee: 15 }, # wednesday at noon
        { time: Time.parse('2022-07-27 19:14:33 -0300'), fee: 17 }, # wednesday at night
        { time: Time.parse('2022-07-30 13:14:33 -0300'), fee: 17 }, # sartuday
        { time: Time.parse('2022-07-31 09:00:00 -0300'), fee: 17 }, # sunday
      ]
     }

     context "when amount below 1000.01" do
      it 'should testcases pass' do
        testcases.each do |testcase|
          expect(subject.fee(testcase[:time])).to eq(testcase[:fee].to_d)
        end
      end
      
     end

     context "when amount above 1000" do
      it 'should testcases pass' do
        subject.amount = 1000.01
        testcases_above_1000.each do |testcase|
          expect(subject.fee(testcase[:time])).to eq(testcase[:fee].to_d)
        end
      end
      
     end
     

    # it 'should be $5 weekday between 9:00 to 18:00' do
    #   wednesday_at_noon = Time.parse('2022-07-27 12:14:33 -0300')
    #   expect(subject.fee(wednesday_at_noon)).to eq(5.to_d)
    # end

    # it 'should be $7 weekday between 18:00:01 to 8:59:59' do
    #   wednesday_at_night = Time.parse('2022-07-27 19:14:33 -0300')
    #   expect(subject.fee(wednesday_at_night)).to eq(7.to_d)
    #   [
    #     Time.parse('2022-07-27 19:14:33 -0300')
    #     Time.parse('2022-07-31 09:00:00 -0300'), # sunday
    #   ].each do |weekend_day|
    #     expect(subject.fee(weekend_day)).to eq(7.to_d)
    #   end
    # end

    # it 'should be $7 during all weekend' do
    #   [
    #     Time.parse('2022-07-30 13:14:33 -0300'), # sartuday
    #     Time.parse('2022-07-31 09:00:00 -0300'), # sunday
    #   ].each do |weekend_day|
    #     expect(subject.fee(weekend_day)).to eq(7.to_d)
    #   end
    # end
    
    # it 'should be $15 at weekday in time range more than $1000' do
    #   wednesday_at_noon = Time.parse('2022-07-27 12:14:33 -0300')
    #   subject.amount = 1000.01
    #   expect(subject.fee(wednesday_at_noon)).to eq(15.to_d)
    # end

    # it 'should be $17 at weekend more than $1000' do
    #   weekend_day = Time.parse('2022-07-30 13:14:33 -0300')
    #   subject.amount = 1000.01
    #   expect(subject.fee(weekend_day)).to eq(17.to_d)
    # end
  end

end
