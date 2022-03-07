require 'rails_helper'

RSpec.describe "Api::V1::CurrentUsers", type: :request do
  describe "GET /index" do
    let!(:user) { create(:user) }
    let(:auth_tokens) { sign_in user }

    before do
      get api_v1_current_users_path, headers: auth_tokens
    end

    it 'ステータスコード200が帰ってくる' do
      expect(response.status).to eq 200
    end

    it 'followingのIDが返ってくる' do
      expect(response.body).to include user.following.ids.to_json
    end

    it 'liked_postsのIDが返ってくる' do
      expect(response.body).to include user.liked_posts.ids.to_json
    end

    it 'disliked_postsのIDが返ってくる' do
      expect(response.body).to include user.disliked_posts.ids.to_json
    end

    it 'book_mark_postsのIDが返ってくる' do
      expect(response.body).to include user.book_mark_posts.ids.to_json
    end

    it 'ログインユーザーのIDが返ってくる' do
      expect(response.body).to include user.id.to_json
    end

    it 'ログインユーザーのnameが返ってくる' do
      expect(response.body).to include user.name.to_json
    end

    it 'ログインユーザーのguestの値が返ってくる' do
      expect(response.body).to include user.guest.to_json
    end
  end
end
