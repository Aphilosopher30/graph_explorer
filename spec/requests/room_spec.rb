require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/room/index"
      expect(response).to have_http_status(:success)
    end
  end

end
