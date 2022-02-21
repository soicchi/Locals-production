require 'rails_helper'

RSpec.describe "Api::V1::HealthChecks", type: :request do
  describe "GET /index" do
    before do
      get api_v1_health_checks_path
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end
  end
end
