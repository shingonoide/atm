require 'rails_helper'

RSpec.describe "Operations", type: :request do
  describe "GET /deposit" do
    it "returns http success" do
      get "/operations/deposit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /withdraw" do
    it "returns http success" do
      get "/operations/withdraw"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /transfer" do
    it "returns http success" do
      get "/operations/transfer"
      expect(response).to have_http_status(:success)
    end
  end

end
