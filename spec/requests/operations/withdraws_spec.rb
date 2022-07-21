require 'rails_helper'

RSpec.describe "Operations::Withdraws", type: :request do
  describe "GET /show" do
    it "returns http success" do
      Deposit.create(account_number: 1234, amount: 1)
      withdraw = Withdraw.create(account_number: 1234, amount: 1)
      get "/operations/withdraws/#{withdraw.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/operations/withdraws/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do
      Deposit.create(account_number: 1234, amount: 5)
      post "/operations/withdraws", params: { withdraw: { account_number: 1234, amount: 5}}
      expect(response).to have_http_status(:redirect)
    end
  end

end
