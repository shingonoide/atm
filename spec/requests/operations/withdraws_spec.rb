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
      get operations_withdraw_url(withdraw)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_operations_withdraw_url
      expect(response).to have_http_status(:success)
    end
    it "returns http redirect" do
      sign_out(@account)
      get new_operations_withdraw_url
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "POST /create" do
    it "returns http redirect" do
      @account.deposits.create(amount: 5)
      post operations_withdraws_url, params: { withdraw: { amount: 5}}
      expect(response).to have_http_status(:redirect)
    end
  end

end
