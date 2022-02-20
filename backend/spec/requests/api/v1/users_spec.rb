require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe 'GET /show' do
    let!(:user) { create(:user) }
    let!(:user_post) { create(:post, user_id: user.id) }
    let!(:post) { create(:post) }
    let!(:book_mark) { create(:book_mark, user_id: user.id, post_id: post.id) }

    before do
      get api_v1_user_path user
    end

    it 'ステータスコードが200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'ユーザー情報が返ってくる' do
      expect(response.body).to include user.id.to_json
    end

    it 'ユーザーに紐付いたフォローしているユーザーのデータが返ってくる' do
      expect(response.body).to include user.following.to_json
    end

    it 'ユーザーに紐付いたフォロワーのデータが返ってくる' do
      expect(response.body).to include user.followers.to_json
    end

    it 'ユーザーに紐付いたブックマークした投稿が返ってくる' do
      expect(response.body).to include user.book_mark_posts.to_json
    end

    it 'いいねした投稿が返ってくる' do
      expect(response.body).to include user.liked_posts.to_json
    end
  end

  describe 'GET :id/user_posts' do
    let!(:user) { create(:user) }
    let!(:other_user1) { create(:user) }
    let!(:other_user2) { create(:user) }
    let!(:user_post) { create(:post, user_id: user.id) }
    let!(:like) { create(:like, user_id: other_user1.id, post_id: user_post.id) }
    let!(:dislike) { create(:dislike, user_id: other_user2.id, post_id: user_post.id) }

    before do
      get user_posts_api_v1_user_path user
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'userの投稿が返ってくる' do
      expect(response.body).to include user_post.id.to_json
    end

    it '投稿に紐付いたユーザーが返ってくる' do
      expect(response.body).to include user.to_json # (methods: :avatar_url)
    end

    it 'いいねしているユーザーのデータが返ってくる' do
      expect(response.body).to include other_user1.to_json
    end

    it 'う〜んの評価をしたユーザーのデータが返ってくる' do
      expect(response.body).to include other_user2.to_json
    end
  end

  describe 'GET /:id/following' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:relationship) { create(:relationship, follower_id: user.id, followed_id: other_user.id) }

    before do
      get following_api_v1_user_path user
    end

    it 'ステータスコードが200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'ユーザーがフォローしているユーザー一覧が返ってくる' do
      expect(response.body).to eq [other_user].to_json
    end
  end

  describe 'GET /:id/followers' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:relationship) { create(:relationship, follower_id: other_user.id, followed_id: user.id) }

    before do
      get followers_api_v1_user_path user
    end

    it 'ステータスコードが200' do
      expect(response.status).to eq 200
    end

    it 'ユーザーのフォロワー一覧が返ってくる' do
      expect(response.body).to eq [other_user].to_json
    end
  end

  describe 'GET /book_mark_posts' do
    let!(:user) { create(:user) }
    let!(:other_user1) { create(:user) }
    let!(:other_user2) { create(:user) }
    let!(:other_user1_post) { create(:post, user_id: other_user1.id) }
    let!(:book_mark) { create(:book_mark, user_id: user.id, post_id: other_user1_post.id) }
    let!(:like) { create(:like, user_id: user.id, post_id: other_user1_post.id) }
    let!(:dislike) { create(:dislike, user_id: other_user2.id, post_id: other_user1_post.id) }
    # let!(:category) { create(:category) }
    # let!(:classificaton) { create(:classification, post_id: other_user1_post.id, category_id: category.id) }
    let(:auth_tokens) { sign_in user }

    before do
      get book_mark_posts_api_v1_users_path, headers: auth_tokens
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'ログインユーザーのブックマークした投稿一覧が返ってくる' do
      expect(response.body).to include other_user1_post.id.to_json
    end

    it '投稿に紐づくユーザーが返ってくる' do
      expect(response.body).to include other_user1.to_json # (methods: :avatar_url)
    end

    it 'いいねしているユーザーのデータが返ってくる' do
      expect(response.body).to include user.id.to_json
    end

    it 'う〜んの評価をしたユーザーのデータが返ってくる' do
      expect(response.body).to include other_user2.to_json
    end

    # it 'カテゴリーのnameが返ってくる' do
    #   expect(response.body).to include category.name.to_json
    # end
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
    # let!(:category) { create(:category) }
    # let!(:classificaton) { create(:classification, post_id: other_user1_post.id, category_id: category.id) }
    let(:auth_tokens) { sign_in user }

    before do
      get following_posts_api_v1_users_path, headers: auth_tokens
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'フォローしているユーザーの投稿が返ってくる' do
      expect(response.body).to include other_user1_post.id.to_json
    end

    it '投稿に紐付いたuserが含まれている' do
      expect(response.body).to include other_user1.to_json # (methods: :avatar_url)
    end

    it 'いいねしているユーザーのデータが返ってくる' do
      expect(response.body).to include user.id.to_json
    end

    it 'う〜んの評価をしたユーザーのデータが返ってくる' do
      expect(response.body).to include other_user2.to_json
    end

    # it 'カテゴリーのnameが返ってくる' do
    #   expect(response.body).to include category.name.to_json
    # end
  end

  describe 'GET /liked_posts' do
    let!(:user) { create(:user) }
    let!(:other_user_post) { create(:post) }
    let!(:like) { create(:like, user_id: user.id, post_id: other_user_post.id) }
    let(:auth_tokens) { sign_in user }

    before do
      get liked_posts_api_v1_users_path, params: { id: user.id }, headers: auth_tokens
    end

    it 'いいねした投稿の店名が返ってくる' do
      expect(response.body).to include other_user_post.restaurant_name
    end
  end
end
