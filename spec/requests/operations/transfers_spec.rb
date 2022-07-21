require 'rails_helper'

RSpec.describe "Operations::Transfers", type: :request do
  describe "GET /operations/transfer" do
    it "create a transfer between accounts" do
      Account.create(account_number: 1234, password: 123456)
      Account.create(account_number: 4321, password: 123456)
      Deposit.create(account_number: 1234, amount: 100)
      params = { transfer: {account_number: 1234, to_account_number: 4321, amount: 10} }

      post "/operations/transfers", params: params
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to eql "Transfer was successfully created."

    end
  end
end
