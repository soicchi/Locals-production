require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe 'GET /show' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:user_post) { create(:post, user_id: user.id) }
    let!(:post) { create(:post) }
    let!(:other_user_post) { create(:post) }
    let!(:avtive_relationship) { create(:relationship, follower_id: user.id, followed_id: other_user.id) }
    let!(:passive_relationship) { create(:relationship, follower_id: other_user.id, followed_id: user.id) }
    let!(:book_mark) { create(:book_mark, user_id: user.id, post_id: post.id) }
    let!(:user_like) { create(:like, user_id: user.id, post_id: other_user_post.id) }

    before do
      get api_v1_user_path user
    end

    it 'ステータスコードが200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'ユーザーのid, name, introduction, avatar_urlが返ってくる' do
      expect(response.body).to include(
        user.id.to_json,
        user.name.to_json,
        user.introduction.to_json,
        user.avatar_url.to_json
      )
    end

    it 'ユーザーに紐づくpostsが返ってくる' do
      expect(response.body).to include user_post.to_json(
        include: [
          { user: { methods: :avatar_url, only: [:id, :name, :avatar_url] } },
          { like_users: { only: :id } },
          { dislike_users: { only: :id } },
          { categories: { only: :name } }
        ],
        methods: [:image_url, :like_percentage],
        except: [:comment, :updated_at]
      )
    end

    it 'ユーザーに紐付いたフォローしているユーザーのデータが返ってくる' do
      expect(response.body).to include(
        other_user.id.to_json,
        other_user.name.to_json,
        other_user.avatar_url.to_json
      )
    end

    it 'ユーザーに紐付いたフォロワーのデータが返ってくる' do
      expect(response.body).to include(
        other_user.id.to_json,
        other_user.name.to_json,
        other_user.avatar_url.to_json
      )
    end

    it 'いいねした投稿が返ってくる' do
      expect(response.body).to include other_user_post.id.to_json
    end
  end

  describe 'GET /book_mark_posts' do
    let!(:user) { create(:user) }
    let!(:other_user1) { create(:user) }
    let!(:other_user2) { create(:user) }
    let!(:other_user1_post) { create(:post, user_id: other_user1.id) }
    let!(:user_book_mark) { create(:book_mark, user_id: user.id, post_id: other_user1_post.id) }
    let!(:user_like) { create(:like, user_id: user.id, post_id: other_user1_post.id) }
    let!(:user_dislike) { create(:dislike, user_id: other_user2.id, post_id: other_user1_post.id) }
    let!(:category) { create(:category) }
    let!(:classificaton) { create(:classification, post_id: other_user1_post.id, category_id: category.id) }
    let(:auth_tokens) { sign_in user }

    before do
      get book_mark_posts_api_v1_users_path, headers: auth_tokens
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'ログインユーザーのブックマークした投稿一覧が返ってくる' do
      expect(response.body).to include other_user1_post.to_json(
        include: [
          { user: { methods: :avatar_url } },
          { like_users: { only: :id } },
          { dislike_users: { only: :id } },
          { categories: { only: :name } }
        ],
        methods: [:image_url, :like_percentage],
        except: [:comment, :updated_at]
      )
    end

    it '投稿に紐づくユーザーが返ってくる' do
      expect(response.body).to include other_user1.to_json(methods: :avatar_url)
    end

    it '投稿いいねしてきたユーザーIDが返ってくる' do
      expect(response.body).to include user.id.to_json
    end

    it '投稿にう〜んの評価をしてきたユーザーIDが返ってくる' do
      expect(response.body).to include other_user2.id.to_json
    end

    it 'カテゴリーのnameが返ってくる' do
      expect(response.body).to include category.name.to_json
    end
  end

  describe 'GET /liked_posts_ids' do
    let!(:user) { create(:user) }
    let!(:post1) { create(:post) }
    let!(:post2) { create(:post) }
    let!(:like1) { create(:like, user_id: user.id, post_id: post1.id) }
    let!(:like2) { create(:like, user_id: user.id, post_id: post2.id) }
    let!(:auth_tokens) { sign_in user }

    before do
      get liked_posts_ids_api_v1_users_path, headers: auth_tokens
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'いいねした投稿のIDが返ってくる' do
      expect(response.body).to eq([post2.id, post1.id].to_json)
    end
  end

  describe 'GET /disliked_posts_ids' do
    let!(:user) { create(:user) }
    let!(:post1) { create(:post) }
    let!(:post2) { create(:post) }
    let!(:dislike1) { create(:dislike, user_id: user.id, post_id: post1.id) }
    let!(:dislike2) { create(:dislike, user_id: user.id, post_id: post2.id) }
    let(:auth_tokens) { sign_in user }

    before do
      get disliked_posts_ids_api_v1_users_path, headers: auth_tokens
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'う〜んの評価をした投稿のIDが返ってくる' do
      expect(response.body).to eq([post2.id, post1.id].to_json)
    end
  end

  describe 'GET /following_posts' do
    let!(:user) { create(:user) }
    let!(:other_user1) { create(:user) }
    let!(:other_user2) { create(:user) }
    let!(:other_user1_post) { create(:post, user_id: other_user1.id) }
    let!(:relationship) { create(:relationship, follower_id: user.id, followed_id: other_user1.id) }
    let!(:like) { create(:like, user_id: user.id, post_id: other_user1_post.id) }
    let!(:dislike) { create(:dislike, user_id: other_user2.id, post_id: other_user1_post.id) }
    let!(:category) { create(:category) }
    let!(:classificaton) { create(:classification, post_id: other_user1_post.id, category_id: category.id) }
    let(:auth_tokens) { sign_in user }

    before do
      get following_posts_api_v1_users_path, headers: auth_tokens
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'フォロー済みユーザーの投稿のid, restaurant, station, image_url, created_atが返ってくる' do
      expect(response.body).to include(
        other_user1_post.id.to_json,
        other_user1_post.restaurant_name.to_json,
        other_user1_post.station.to_json,
        other_user1_post.image_url.to_json,
        other_user1_post.created_at.to_json,
      )
    end

    it '投稿に紐付いたuserのid, name, avatar_urlが含まれている' do
      expect(response.body).to include(
        other_user1.id.to_json,
        other_user1.name.to_json,
        other_user1.avatar_url.to_json
      )
    end

    it 'いいねしているユーザーのIDが返ってくる' do
      expect(response.body).to include user.id.to_json
    end

    it 'う〜んの評価をしたユーザーのIDが返ってくる' do
      expect(response.body).to include other_user2.id.to_json
    end

    it 'カテゴリーのnameが返ってくる' do
      expect(response.body).to include category.name.to_json
    end
  end

  describe 'GET /liked_posts' do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:other_user_post) { create(:post) }
    let!(:like) { create(:like, user_id: user.id, post_id: other_user_post.id) }
    let!(:dislike) { create(:dislike, user_id: user2.id, post_id: other_user_post.id) }
    let!(:category) { create(:category) }
    let!(:classification) { create(:classification, post_id: other_user_post.id, category_id: category.id) }
    let(:auth_tokens) { sign_in user }

    before do
      get liked_posts_api_v1_users_path, params: { id: user.id }, headers: auth_tokens
    end

    it 'いいねした投稿のid, restaurant_name, station, image_url, created_atが返ってくる' do
      expect(response.body).to include(
        other_user_post.id.to_json,
        other_user_post.restaurant_name.to_json,
        other_user_post.station.to_json,
        other_user_post.image_url.to_json,
        other_user_post.created_at.to_json,
      )
    end

    it '投稿にいいねしたユーザーのIDが返ってくる' do
      expect(response.body).to include user.id.to_json
    end

    it '投稿にう〜んの評価をしたユーザーのIDが返ってくる' do
      expect(response.body).to include user2.id.to_json
    end

    it '投稿に紐付いているカテゴリー名が返ってくる' do
      expect(response.body).to include category.name.to_json
    end

    it '投稿のimage_urlが返ってくる' do
      expect(response.body).to include other_user_post.image_url.to_json
    end

    it '投稿のlike_percentageが返ってくる' do
      expect(response.body).to include other_user_post.like_percentage.to_json
    end
  end
end
