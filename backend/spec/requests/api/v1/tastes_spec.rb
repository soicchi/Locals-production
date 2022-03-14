require 'rails_helper'

RSpec.describe "Api::V1::Tastes", type: :request do
  describe "GET /index" do
    let!(:taste1) { create(:taste) }
    let!(:taste2) { create(:taste) }

    before do
      get api_v1_tastes_path
    end

    it 'ステータスコード200を返す' do
      expect(response.status).to eq 200
    end

    it 'すべてのtasteのidとcontentが返ってくる' do
      expect(json).to match_array([
        { "id" => taste1.id, "content" => taste1.content },
        { "id" => taste2.id, "content" => taste2.content }
      ])
    end
  end
end
