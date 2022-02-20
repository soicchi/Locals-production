require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  describe 'GET /index' do
    let!(:post1) { create(:post) }
    let!(:post2) { create(:post) }

    before do
      get api_v1_posts_path
    end

    it 'ステータスコードが200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'すべての投稿データが返ってくる' do
      expect(response.body).to include post1.comment, post2.comment
    end

    it '投稿に紐づくユーザーデータも返ってくる' do
      expect(response.body).to include post1.user.name, post2.user.name
    end

    it '投稿に紐づくlike_usersが返ってくる' do
      expect(response.body).to include post1.like_users.to_json, post2.like_users.to_json
    end

    it '投稿に紐づくdislike_usersが返ってくる' do
      expect(response.body).to include post1.dislike_users.to_json, post2.dislike_users.to_json
    end

    it '投稿に紐づくカテゴリーのidが返ってくる' do
      expect(response.body).to include post1.categories.ids.to_json, post2.categories.ids.to_json
    end
  end

  describe 'GET /show' do
    let!(:post) { create(:post) }

    before do
      get api_v1_post_path(post)
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'postの投稿データが返ってくる' do
      expect(response.body).to include post.id.to_json
    end

    it 'postに紐づくuserが返ってくる' do
      expect(response.body).to include post.user.id.to_json
    end

    it 'postにいいねの評価をしたユーザー数が返ってくる' do
      expect(response.body).to include post.like_users.to_json
    end

    it 'postにう〜んの評価をしたユーザー数が返ってくる' do
      expect(response.body).to include post.dislike_users.to_json
    end

    it 'postに紐づくカテゴリーのidが返ってくる' do
      expect(response.body).to include post.categories.ids.to_json
    end
  end

  describe 'POST /create' do
    let!(:user) { create(:user) }
    let(:auth_tokens) { sign_in user }

    # context '投稿が成功する場合' do
    #   let!(:category) { create(:category) }
    #   let(:image_url) { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '5mb_image.jpg')) }
    #   let(:post_params) { attributes_for(:post, category_ids: [category.id], images: [image_url]) }
    #   let(:success_message) { '投稿が作成されました' }

    #   before do
    #     post api_v1_posts_path, params: post_params, headers: auth_tokens
    #   end

    #   it 'ステータスコード200が返ってくる' do
    #     expect(response.status).to eq 200
    #   end

    #   it '投稿作成時のmessageが返ってくる' do
    #     expect(json['message']).to eq success_message
    #   end
    # end

    context '投稿が失敗する場合' do
      before do
        post api_v1_posts_path, headers: auth_tokens
      end

      it 'ステータスコード400が返ってくる' do
        expect(response.status).to eq 400
      end
    end

    context '許可されていないパラメーターが送られてきた場合' do
      before do
        post api_v1_posts_path, params: { admin: true }, headers: auth_tokens
      end

      it 'ステータスコード400を返す' do
        expect(response.status).to eq 400
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:user_post) { create(:post, user_id: user.id) }

    context '自分の投稿を削除しようとした場合' do
      let(:auth_tokens) { sign_in user }
      let(:success_message) { '投稿が削除されました' }

      before do
        delete api_v1_post_path(user_post), headers: auth_tokens
      end

      it 'ステータスコード200が返ってくる' do
        expect(response.status).to eq 200
      end

      it '該当する投稿が削除される' do
        expect(user.posts.reload).not_to include user_post
      end

      it 'messageが返される' do
        expect(json['message']).to eq success_message
      end
    end

    context '他者の投稿を削除しようとした場合' do
      let(:auth_tokens) { sign_in other_user }

      before do
        delete api_v1_post_path user_post, headers: auth_tokens
      end

      it 'ステータスコード401が返ってくる' do
        expect(response.status).to eq 401
      end

      it '該当する投稿は削除されない' do
        expect(user.posts.reload).to include user_post
      end
    end
  end
end
