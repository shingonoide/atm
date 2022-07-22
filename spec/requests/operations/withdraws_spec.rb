require 'rails_helper'

RSpec.describe "Operations::Withdraws", type: :request do
  before :each do
    @account = Account.create(password: 123456)
    sign_in(@account)
  end
  
  describe "GET /show" do
    it "returns http success" do
      @account.deposits.create(amount: 1)
      withdraw = @account.withdraws.create(amount: 1)
      get "/operations/withdraws/#{withdraw.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/operations/withdraws/new"
      expect(response).to have_http_status(:success)
    end
    it "returns http redirect" do
      sign_out(@account)
      get "/operations/withdraws/new"
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do
      @account.deposits.create(amount: 5)
      post "/operations/withdraws", params: { withdraw: { account_number: @account.account_number, amount: 5}}
      expect(response).to have_http_status(:redirect)
    end
  end

end
