require 'rails_helper'

RSpec.describe "Operations::Deposits", type: :request do
  describe "GET /operations/deposits/new" do
    it "New deposit operation page" do
      get new_operations_deposit_path
      expect(response).to have_http_status(200)
    end
  end
end
