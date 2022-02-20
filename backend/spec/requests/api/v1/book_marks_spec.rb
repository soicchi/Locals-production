require 'rails_helper'

RSpec.describe "Api::V1::BookMarks", type: :request do
  describe 'POST /create' do
    let!(:user) { create(:user) }
    let(:auth_tokens) { sign_in user }

    context '他人の投稿をブックマークする場合' do
      let!(:other_user) { create(:user) }
      let!(:other_post) { create(:post, user_id: other_user.id) }
      let(:success_message) { 'ブックマークしました' }

      before do
        post api_v1_book_marks_path, params: { post_id: other_post.id }, headers: auth_tokens
      end

      it 'ステータスコード200が返ってくる' do
        expect(response.status).to eq 200
      end

      it 'ブックマークが作成される' do
        expect(user.book_mark_posts).to include other_post
      end

      it 'メッセージが返ってくる' do
        expect(json['message']).to eq success_message
      end
    end

    context '自分自身の投稿をブックマークする場合' do
      let!(:my_post) { create(:post, user_id: user.id) }

      before do
        post api_v1_book_marks_path, params: { post_id: my_post.id }, headers: auth_tokens
      end

      it 'ブックマークは作成されない' do
        expect(user.book_mark_posts).not_to include my_post
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:other_post) { create(:post, user_id: other_user.id) }
    let!(:book_mark) { user.book_mark other_post }
    let(:auth_tokens) { sign_in user }
    let(:message) { 'ブックマークを解除しました' }

    before do
      delete api_v1_book_mark_path(other_post.id), headers: auth_tokens
    end

    it 'ステータスコード200が返ってくる' do
      expect(response.status).to eq 200
    end

    it 'ブックマークが削除される' do
      expect(user.book_mark_posts).not_to include other_post
    end

    it 'メッセージが返される' do
      expect(json['message']).to eq message
    end
  end
end
