require 'rails_helper'

RSpec.describe "Api::V1::Searches", type: :request do
  describe "GET /index" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:user_post) { create(:post, user_id: user.id, category_ids: [category.id]) }
    let!(:other_user_post) { create(:post, user_id: other_user.id) }

    context 'category_idsがnilではなかった場合' do
      before do
        get api_v1_search_path, params: { category_ids: [user_post.category_ids] }
      end

      it 'ステータスコード200が返ってくる' do
        expect(response.status).to eq 200
      end

      it 'categoryが含まれた投稿が返ってくる' do
        expect(response.body).to include user_post.id.to_json
      end

      it 'カテゴリーが完全一致しない投稿は返ってこない' do
        expect(response.body).not_to include other_user_post.id.to_json
      end
    end

    context 'category_idsがnilの場合' do
      before do
        get api_v1_search_path
      end

      it 'ステータスコード200が返ってくる' do
        expect(response.status).to eq 200
      end

      it 'すべての投稿を返す' do
        expect(response.body).to include user_post.comment.to_json
      end
    end

    context '該当する投稿がない場合' do
      let!(:other_category) { create(:category) }
      let(:error_message) { '該当する投稿はありませんでした' }

      before do
        get api_v1_search_path, params: { category_ids: [other_category.id] }
      end

      it 'ステータスコード400が返ってくる' do
        expect(response.status).to eq 400
      end

      it 'メッセージが返ってくる' do
        expect(json['message']).to eq error_message
      end
    end
  end
end
