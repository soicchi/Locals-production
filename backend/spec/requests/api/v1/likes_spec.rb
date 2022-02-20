require 'rails_helper'

RSpec.describe "Api::V1::Likes", type: :request do
  describe "POST /create" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:other_user_post) { create(:post, user_id: other_user.id) }
    let(:auth_tokens) { sign_in user }

    context 'いいねしていない投稿にいいねする場合' do
      let(:success_message) { 'いいねしました' }

      before do
        post api_v1_likes_path, params: { post_id: other_user_post.id }, headers: auth_tokens
      end

      it 'ステータスコード204を返す' do
        expect(response.status).to eq 204
      end

      it 'いいねが登録される' do
        expect(user.liked_posts).to include other_user_post
      end
    end

    # context 'う〜んしている投稿をいいねする場合' do
    #   let!(:dislike) { create(:dislike, user_id: user.id, post_id: other_user_post.id) }

    #   before do
    #     post api_v1_likes_path, params: { post_id: other_user_post.id }, headers: auth_tokens
    #   end

    #   it 'ステータスコード204が返ってくる' do
    #     expect(response.status).to eq 204
    #   end

    #   it 'いいねが登録される' do
    #     expect(user.liked?(other_user_post)).to eq true
    #   end

    #   it 'う〜んが削除される' do
    #     expect(user.disliked?(other_user_post)).to eq false
    #   end
    # end

    context 'いいね済みの投稿をいいねする場合' do
      let(:error_message) { 'いいねができませんでした' }
      let!(:like) { create(:like, user_id: user.id, post_id: other_user_post.id) }
      let!(:default_like_count) { user.liked_posts.count }

      before do
        post api_v1_likes_path, params: { post_id: other_user_post.id }, headers: auth_tokens
      end

      it 'ステータスコード400を返す' do
        expect(response.status).to eq 400
      end

      it '新たにいいねをつけることはできない' do
        expect(default_like_count).to eq user.liked_posts.count
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

    context '元々いいねしている場合' do
      before do
        user.like(other_user_post)
        delete api_v1_like_path(other_user_post.id), headers: auth_tokens
      end

      it 'ステータスコード204を返す' do
        expect(response.status).to eq 204
      end

      it 'いいねが解除される' do
        expect(user.liked_posts).not_to include other_user_post
      end
    end

    context '元々いいねしてない場合' do
      let(:error_message) { '元からいいねされていません' }

      before do
        delete api_v1_like_path(other_user_post.id), headers: auth_tokens
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
