require 'rails_helper'

RSpec.describe "Operations", type: :request do
  describe "GET /" do
    it "returns http success" do
      get operations_path
      expect(response).to have_http_status(:success)
    end
  end

end
