require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  describe 'GET /index' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:user_post) { create(:post, user_id: user.id) }
    let!(:other_user_post) { create(:post, user_id: other_user.id) }
    let!(:like) { create(:like, user_id: user.id, post_id: other_user_post.id) }
    let!(:dislike) { create(:dislike, user_id: other_user.id, post_id: user_post.id) }
    let!(:category) { create(:category) }
    let!(:classification1) { create(:classification, post_id: user_post.id, category_id: category.id) }
    let!(:classification2) { create(:classification, post_id: other_user_post.id, category_id: category.id) }

    before do
      get api_v1_posts_path
    end

    it 'ステータスコードが200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'user_postのid, restaurant_name, station, created_atデータが返ってくる' do
      expect(response.body).to include(
        user_post.id.to_json,
        user_post.restaurant_name.to_json,
        user_post.station.to_json,
        user_post.created_at.to_json
      )
    end

    it 'other_user_postのid, restaurant_name, station, created_atデータが返ってくる' do
      expect(response.body).to include(
        other_user_post.id.to_json,
        other_user_post.restaurant_name.to_json,
        other_user_post.station.to_json,
        other_user_post.created_at.to_json
      )
    end

    it '各投稿のtastesが返ってくる' do
      expect(response.body).to include(user_post.tastes.to_json, other_user_post.tastes.to_json)
    end

    it '投稿に紐づくユーザーデータも返ってくる' do
      expect(response.body).to include(
        user.to_json(methods: :avatar_url, only: [:id, :name, :avatar_url]),
        other_user.to_json(methods: :avatar_url, only: [:id, :name, :avatar_url])
      )
    end

    it '投稿に紐づくlike_usersのID返ってくる' do
      expect(response.body).to include user.id.to_json
    end

    it '投稿に紐づくdislike_usersのIDが返ってくる' do
      expect(response.body).to include user.id.to_json
    end

    it '投稿に紐づくカテゴリーのnameが返ってくる' do
      expect(response.body).to include category.name.to_json
    end

    it '各投稿にcommentとupdated_atは含まれていない' do
      expect(response.body).not_to include(
        user_post.updated_at.to_json,
        other_user_post.updated_at.to_json
      )
    end

    it '投稿のimage_urlが返ってくる' do
      expect(response.body).to include user_post.image_url.to_json
    end

    it '投稿のlike_percentageが返ってくる' do
      expect(response.body).to include user_post.like_percentage.to_json
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
      expect(response.body).to include(
        post.user.id.to_json,
        post.user.name.to_json,
        post.user.avatar_url.to_json
      )
    end

    it 'postにいいねの評価をしたユーザー数が返ってくる' do
      expect(response.body).to include post.like_users.ids.to_json
    end

    it 'postにう〜んの評価をしたユーザー数が返ってくる' do
      expect(response.body).to include post.dislike_users.ids.to_json
    end

    it 'postに紐づくカテゴリーのidが返ってくる' do
      expect(response.body).to include post.categories.ids.to_json
    end

    it 'postのimage_urlが返ってくる' do
      expect(response.body).to include post.image_url.to_json
    end

    it '投稿のlike_percentageが返ってくる' do
      expect(response.body).to include post.like_percentage.to_json
    end

    it '投稿のliked_age_groupが返ってくる' do
      expect(response.body).to include post.liked_age_group.to_json
    end

    it '投稿のdisliked_age_groupが返ってくる' do
      expect(response.body).to include post.disliked_age_group.to_json
    end
  end

  describe 'POST /create' do
    let!(:user) { create(:user) }
    let(:auth_tokens) { sign_in user }

    context '投稿が成功する場合' do
      let!(:taste) { create(:taste) }
      let!(:category) { create(:category) }
      let(:image_url) { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'image.jpg')) }
      let(:post_params) { attributes_for(:post, category_ids: [category.id], images: [image_url], taste_ids: [taste.id]) }
      let(:success_message) { '投稿が作成されました' }

      before do
        post api_v1_posts_path, params: post_params, headers: auth_tokens
      end

      it 'ステータスコード200が返ってくる' do
        expect(response.status).to eq 200
      end

      it '投稿作成時のmessageが返ってくる' do
        expect(json['message']).to eq success_message
      end
    end

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

      it 'ストレージから画像が削除される' do
        expect(user_post.images.blobs).to eq []
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
