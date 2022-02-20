require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do
  describe "GET /index" do
    let!(:category) { create(:category) }
    let!(:other_category) { create(:category) }

    before do
      get api_v1_categories_path
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'すべてのカテゴリーのidが返ってくる' do
      expect(response.body).to include category.id.to_json, other_category.id.to_json
    end

    it 'すべてのカテゴリーのnameが返ってくる' do
      expect(response.body).to include category.name.to_json, other_category.name.to_json
    end
  end
end
