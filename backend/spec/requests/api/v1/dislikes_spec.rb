require 'rails_helper'

RSpec.describe "Api::V1::Dislikes", type: :request do
  describe "POST /create" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:other_user_post) { create(:post, user_id: other_user.id) }
    let(:auth_tokens) { sign_in user }

    context '未評価の投稿にう〜んを付ける場合' do
      before do
        post api_v1_dislikes_path, params: { post_id: other_user_post.id }, headers: auth_tokens
      end

      it 'ステータスコード204が返ってくる' do
        expect(response.status).to eq 204
      end

      it '投稿にう〜んの評価を付ける' do
        expect(user.disliked?(other_user_post)).to eq true
      end
    end

    context 'いいねを付けている投稿にう〜んの評価を付けた場合' do
      let!(:like) { create(:like, user_id: user.id, post_id: other_user_post.id) }

      before do
        post api_v1_dislikes_path, params: { post_id: other_user_post.id }, headers: auth_tokens
      end

      it 'ステータスコード204が返ってくる' do
        expect(response.status).to eq 204
      end

      it '投稿にう〜んの評価を付ける' do
        expect(user.disliked?(other_user_post)).to eq true
      end

      it 'いいねの評価が削除される' do
        expect(user.liked?(other_user_post)).to eq false
      end
    end

    context 'すでに付けている投稿にう〜んを付けようとする場合' do
      let!(:dislike) { create(:dislike, user_id: user.id, post_id: other_user_post.id) }
      let!(:default_dislike_count) { user.dislikes.count }
      let(:error_message) { 'う〜んを付けれませんでした' }

      before do
        post api_v1_dislikes_path, params: { post_id: other_user_post.id }, headers: auth_tokens
      end

      it 'ステータスコード400が返ってくる' do
        expect(response.status).to eq 400
      end

      it '新たにう〜んを付けることができない' do
        expect(default_dislike_count).to eq user.disliked_posts.count
      end

      it 'メッセージが返ってくる' do
        expect(json['message']).to eq error_message
      end
    end

    context '自分の投稿にう〜んをつけようとした場合' do
      let!(:user_post) { create(:post, user_id: user.id) }
      let!(:default_dislike_count) { user.dislikes.count }
      let(:error_message) { 'う〜んを付けれませんでした' }

      before do
        post api_v1_dislikes_path, params: { post_id: user_post.id }, headers: auth_tokens
      end

      it 'ステータスコード400が返ってくる' do
        expect(response.status).to eq 400
      end

      it 'う〜んを付けることはできない' do
        expect(default_dislike_count).to eq user.dislikes.count
      end

      it 'メッセージが返ってくる' do
        expect(json['message']).to eq error_message
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:other_user_post) { create(:post, user_id: other_user.id) }
    let(:auth_tokens) { sign_in user }

    context '元々う〜んをつけている場合' do
      before do
        user.dislike(other_user_post)
        delete api_v1_dislike_path(other_user_post.id), headers: auth_tokens
      end

      it 'ステータスコード204が返ってくる' do
        expect(response.status).to eq 204
      end

      it 'う〜ん...が解除される' do
        expect(user.disliked_posts).not_to include other_user_post
      end
    end

    context '元からう〜んを付けていなかった場合' do
      let(:error_message) { '元からう〜んを付けていません' }

      before do
        delete api_v1_dislike_path(other_user_post.id), headers: auth_tokens
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
