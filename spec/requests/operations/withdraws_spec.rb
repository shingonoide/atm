require 'rails_helper'

RSpec.describe "Operations::Withdraws", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/operations/withdraws/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/operations/withdraws/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/operations/withdraws/create"
      expect(response).to have_http_status(:success)
    end
  end

end
