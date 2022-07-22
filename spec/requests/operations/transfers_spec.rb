require 'rails_helper'

RSpec.describe "Operations::Transfers", type: :request do
  before :each do
    @account1 = Account.create(password: 123456)
    @account2 = Account.create(password: 123456)
    sign_in(@account1)
  end

  describe "POST /operations/transfers" do
    it "create a transfer between accounts" do
      @account1.deposits.create(amount:100)
      params = { transfer: {account_number: @account1.account_number, to_account_number: @account2.account_number, amount: 10} }

      post "/operations/transfers", params: params
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to eql "Transfer was successfully created."

    end
  end
end
