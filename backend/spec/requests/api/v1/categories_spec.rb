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

  describe 'POST /create' do
    let!(:admin_user) { create(:user, :admin) }
    let!(:not_admin_user) { create(:user) }
    let!(:default_category_count) { Category.count }
    let(:category_name) { '魚' }

    context 'adminがtrueの場合' do
      let(:auth_tokens) { sign_in admin_user }

      before do
        post api_v1_categories_path, params: { name: category_name }, headers: auth_tokens
      end

      it 'ステータスコード200が返ってくる' do
        expect(response.status).to eq 200
      end

      it 'カテゴリーが追加される' do
        expect(Category.count).to eq default_category_count + 1
      end

      it '返ってくるカテゴリー一覧に追加したカテゴリーが含まれている' do
        expect(response.body).to include category_name.to_json
      end
    end

    context 'adminがfalseの場合' do
      let(:auth_tokens) { sign_in not_admin_user }

      before do
        post api_v1_categories_path, params: { name: category_name }, headers: auth_tokens
      end

      it 'ステータスコード401が返っている' do
        expect(response.status).to eq 401
      end

      it 'カテゴリーは追加されない' do
        expect(Category.count).to eq default_category_count
      end
    end
  end
end
