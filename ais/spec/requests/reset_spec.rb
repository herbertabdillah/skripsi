require 'rails_helper'

RSpec.describe "Resets", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/reset/index"
      expect(response).to have_http_status(:success)
    end
  end

end
